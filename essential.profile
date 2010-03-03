<?php
/**
 * @file
 * Install and configure an essential starting point for site building.
 * By Richard Burford (freestylesystems.co.uk) and Balazs Dianiska (longlake.co.uk).
 * Profile should use the essential.make makefile, stored with this profile.
 * Features:
 * - essential modules for sitebuilding
 * - page content type
 * - disable every caching
 * - error reporting on screen
 * - disable update status
 * - default username and password: admin/drupal
 * - disable all blocks
 * - Time format set to UK standards
 * - default theme set to clean_starter
 * - reset site footer, mission, slogan and offline messages
 * - allows both authenticated and anonymous users to access content.
 */

/**
 * Modules the profile will install itself.
 */
function essential_profile_modules() {
	return array(
		// Core modules.
		'block', 'dblog', 'filter', 'node', 'taxonomy', 'menu', 'system', 'user', 'path',
		// CTools, required by many modules.
		'ctools',
		// Token
		'token',
		// Admin menu
		'admin_menu', 
		// Admin role
		'adminrole',
		// Features
    'features', 
    // Views
		'views', 'views_ui',
		// Context
		'context', 'context_ui', 'context_contrib',

		// Image related modules.
		'imageapi', 'imageapi_gd', 'imagecache', 'imagecache_ui',
		
		// Vertical tabs
		'vertical_tabs',
		
		// Development related modules.
		'devel', 'devel_generate',
		'coder', 'install_profile_api', 'cvs_deploy',
		
		// Node export to be able to import initial node content.
		'node_export',
		// Node clone
		'clone',
		'transliteration',
		'poormanscron',
	);
}

/**
 * Modules the profile installs in batch processes.
 */
function _essential_secondary_modules() {
	return array(
	  // Panels
	  'panels', 'panels_mini',
	  // Webform
	  'webform',
	  // CCK
	  'content', 
	    // Submodules offered by CCK
	    'text', 'number', 'nodereference',
	    // CCK modules from contrib.
	    'link', 'email', 'filefield', 'filefield_paths', 'imagefield',
	  // Custom features come below.
	);
}

function essential_profile_details() {
	return array(
		'name' => 'Essential',
		'description' => 'Essential layout installer.'
	);
}

function system_form_install_select_profile_form_alter(&$form, $form_state) {
	foreach($form['profile'] as $key => $element) {
		$form['profile'][$key]['#value'] = 'essential';
	}
}

function system_form_install_configure_form_alter(&$form, $form_state) {
 	$form['site_information']['site_name']['#default_value'] = 'Essential'; // TODO change this
 	$form['site_information']['site_mail']['#default_value'] = 'admin@'. $_SERVER['HTTP_HOST'];
 	$form['admin_account']['account']['name']['#default_value'] = 'admin';
 	$form['admin_account']['account']['mail']['#default_value'] = 'admin@'. $_SERVER['HTTP_HOST'];
	$form['admin_account']['account']['pass'] = array(
		'#value' => 'drupal',
		'#type' => 'value',
	);
	$form['server_settings']['date_default_timezone']['#type'] = 'value';
	$form['server_settings']['update_status_module']['#default_value'] = array(0);
}


// "Inspired" by open atrium.
function essential_profile_tasks(&$task, $url) {
  // Install profile api requires including the list of modules we install.
  install_include(essential_profile_modules()); 
	$output = '';
	// We are running a batch task for this profile so basically do nothing and return page
	if (in_array($task, array('essential-modules-batch', 'essential-configure-batch'))) {
		include_once 'includes/batch.inc';
	  $output = _batch_page();
	}
	
	$modules = _essential_secondary_modules();
	$files = module_rebuild_cache();
	
	if ('profile' == $task) {
		foreach ($modules as $module) {
			$batch['operations'][] = array('_install_module_batch', array($module, $files[$module->info['name']]));
		}

	 	$batch['title'] = st('Installing @drupal', array('@drupal' => drupal_install_profile_name()));
		$batch['finished'] = '_essential_module_batch_finished';
	 	$batch['error_message'] = st('The installation has encountered an error.');
	 	
	 	// Start a batch, switch to 'essential-modules-batch' task. We need to
	 	// set the variable here, because batch_process() redirects.
	 	variable_set('install_task', 'essential-modules-batch');
	 	batch_set($batch);
	 	batch_process($url, $url);
	 	// Jut for cli installs. We'll never reach here on interactive installs.
		return;
	}
	
	if ('profile-configure' == $task) {
	 	$batch['title'] = st('Configuring @drupal', array('@drupal' => drupal_install_profile_name()));
 		$batch['operations'][] = array('_essential_configure', array());
	 	$batch['finished'] = '_essential_configure_finished';
	 	variable_set('install_task', 'essential-configure-batch');
	 	batch_set($batch);
	 	batch_process($url, $url);
	 	// Jut for cli installs. We'll never reach here on interactive installs.
	 	return;
	}	
	return $output;
}

/**
 * Batch callbacks for different installation stages.
 */

/**
 * Move on to the configuration stage by setting the task.
 */
function _essential_module_batch_finished($success, $results) {
	variable_set('install_task', 'profile-configure');
}

/**
 * First stage configuration, eg to create a taxonomy.
 */
function _essential_configure($success, $results) {
  // Making sure that we have full error reporting, log and on screen.
  variable_set('error_level', '1');
  
  // Turning all caching off (this is default, but for later reference).
  variable_set('cache', '0');
  variable_set('block_cache', '0');
  // Maximum age for cache.
  variable_set('cache_lifetime', '0');
  variable_set('page_cache_max_age', '0');
  // CSS and JS compression.
  variable_set('preprocess_css', '0');
  variable_set('preprocess_js', '0');
  // Page compression off.
  variable_set('page_compression', '0');
  
  // Hide the details on the admin block for the admin (1) user.
  $account = user_load(array('uid' => 1));
  user_save($account, array('admin_compact_mode' => TRUE));

  // UK standard timestamps.
  variable_set('date_first_day', '1'); // First day of the week is Monday (def: Sun).
  variable_set('date_format_long', "l, j F, Y - H:i"); // j: Day of the month without leading zeros.
  variable_set('date_format_long_custom', "l, F j, Y - H:i");
  variable_set('date_format_medium', "D, m/d/Y - H:i");
  variable_set('date_format_medium_custom', "D, m/d/Y - H:i");
  variable_set('date_format_short', "m/d/Y - H:i");
  variable_set('date_format_short_custom', "m/d/Y - H:i");
  
  // Admin theme set to use default theme.
  variable_set('admin_theme', '0');
  
  // Unset slogan, mission and footer.
  variable_set('site_slogan', '');
  variable_set('site_mission', '');
  variable_set('site_footer', '');
  
  // Default site status and offline message.
  variable_set('site_offline', '0');
  variable_set('site_offline_message', 'Essential is currently under maintenance. We should be back shortly. Thank you for your patience.');
  
  // Add both user groups the permission to access content.
  install_add_permissions(1, 'access_content');
  install_add_permissions(2, 'access_content');
  
	node_access_rebuild();
	_install_node_types();
	
	_block_rehash(); // Populate the blocks table so we can update.
	drupal_flush_all_caches(); // Rebuild key tables/caches

	db_query("UPDATE {blocks} SET status = 0, region = ''"); // disable all DB blocks
	variable_set('theme_default', 'clean_starter');
}

/**
 * Final stage of the configuration.
 */
function _essential_configure_finished($success, $results) {
  variable_set('install_task', 'profile-finished');
}

/**
 * Declaring the page content type manually.
 */
function _install_node_types() {
  $types = array(
    array(
      'type' => 'page',
      'name' => st('Page'),
      'module' => 'node',
      'description' => st("A static site <em>page</em> is a simple method for creating and 
        displaying information that rarely changes, such as an \"About us\" section of a website. 
        By default, a <em>page</em> entry does not allow visitor comments and is not featured on the site's initial home page."),
      'custom' => TRUE,
      'modified' => TRUE,
      'locked' => FALSE,
      'help' => '',
      'min_word_count' => '',
    ),
  );
  foreach ($types as $type) {
    $type = (object) _node_type_set_defaults($type);
    node_type_save($type);
  }

  // Default page to not be promoted and have comments disabled.
  variable_set('node_options_page', array('status'));
  
  // Don't display date and author information for page nodes by default.
  $theme_settings = variable_get('theme_settings', array());
  $theme_settings['toggle_node_info_page'] = FALSE;
  variable_set('comment_page', COMMENT_NODE_DISABLED);
	variable_set('theme_settings', $theme_settings); 
}