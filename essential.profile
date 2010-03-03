<?php

/**
 * Modules the profile will install itself.
 */
function essential_profile_modules() {
	return array(
		// Core modules.
		'block', 'dblog', 'filter', 'node', 'taxonomy', 'menu', 'system', 'user', 'path',
		// Contrib
		'admin_menu', 'features', 'views', 'views_ui',
		'context', 'context_ui', 'context_contrib',
		// CTools.
		'ctools',
		// Date
		'date_api',

		// Image
		'imageapi', 'imageapi_gd', 'imagecache', 'imagecache_ui',
		// Token
		'token',
		
		// Block edit links
		'block_edit',
		// Compact forms
		'compact_forms',
		
		// Development related modules.
		'devel', 'devel_generate',
		
		// Node export to be able to import initial node content.
		'node_export',
	);
}

/**
 * Modules the profile installs in batch processes.
 */
function _essential_secondary_modules() {
	return array(
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
}


// "Inspired" by open atrium.
function essential_profile_tasks(&$task, $url) {
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
		$batch['finished'] = '_essential_profile_batch_finished';
	 	$batch['error_message'] = st('The installation has encountered an error.');
	 	
	 	// Start a batch, switch to 'intranet-modules-batch' task. We need to
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
	 	$batch['operations'][] = array('_essential_configure_check', array());
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
 * Move on to the configuration stage by setting the task.
 */
function _essential_profile_batch_finished($success, $results) {
	variable_set('install_task', 'profile-configure');
}

/**
 * First stage configuration, eg to create a taxonomy.
 */
function _essential_configure($success, $results) {
}

/**
 * Second stage configuration.
 */
function _essential_configure_check($success, $results) {
	node_access_rebuild();
	_block_rehash(); // Populate the blocks table so we can update.
	
	// Rebuild key tables/caches
	drupal_flush_all_caches();

	db_query("UPDATE {blocks} SET status = 0, region = ''"); // disable all DB blocks
	variable_set('theme_default', 'clean');
}
