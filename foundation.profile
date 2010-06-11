<?php
/**
 * @file
 * Install and configure a new Drupal site.
 *
 * Features:
 * - Essential modules for site building
 * - Page content type
 * - Disable all caching
 * - Error reporting on screen
 * - Disable update status
 * - Default username and password is admin:drupal
 * - Disable all blocks
 * - Time format set to UK standards
 * - Default theme set to clean_starter
 * - Reset site footer, mission, slogan and offline messages
 * - Allows both authenticated and anonymous users to access content.
 */

/**
 * Modules the profile will install itself.
 */
function foundation_profile_modules() {
  return array(
    'block',
    'dblog',
    'filter',
    'node',
    'taxonomy',
    'menu', 'system', 'user', 'path',
    'ctools',
    'strongarm',
    'node_export',
    'clone',
    'boxes',
    'token',
    'admin_menu',
    'adminrole',
    'features',
    'views',
    'views_ui',
    'context',
    'context_ui',
    'context_contrib',
    'imageapi',
    'imageapi_gd',
    'imagecache',
    'imagecache_ui',
    'vertical_tabs',
    'devel',
    'devel_generate',
    'coder',
    'install_profile_api',
    'cvs_deploy',
    'transliteration',
    'poormanscron',
    'blocks404',
    'pathauto',
    'advanced_help',
    'panels',
    'panels_mini',
    'webform',
    'content',
    'text',
    'number',
    'nodereference',
    'optionwidgets',
    'link','email',
    'filefield',
    'filefield_paths',
    'imagefield',
  );
}

/**
 * Modules required specifically for the project and features.
 */
function _foundation_secondary_modules() {
  return array(
    'essential',
  );
}

function foundation_profile_details() {
  return array(
    'name' => 'Foundation installer',
    'description' => 'Install a new site using the foundation install profile.',
  );
}

function system_form_install_select_profile_form_alter(&$form, $form_state) {
  foreach($form['profile'] as $key => $element) {
    $form['profile'][$key]['#value'] = 'foundation';
  }
}

function system_form_install_configure_form_alter(&$form, $form_state) {
  $form['site_information']['#collapsible'] = TRUE;
  $form['site_information']['#collapsed'] = TRUE;
  $form['site_information']['site_name']['#default_value'] = 'Foundation installer';
  $form['site_information']['site_mail']['#default_value'] = 'admin@example.com';
  // Collapse the fieldset so we don't need to scroll to the submit button.
  $form['admin_account']['#collapsible'] = TRUE;
  $form['admin_account']['#collapsed'] = TRUE;
  $form['admin_account']['account']['name']['#default_value'] = 'admin';
  $form['admin_account']['account']['mail']['#default_value'] = 'admin@example.com';
  $form['admin_account']['account']['pass'] = array(
    '#value' => 'drupal',
    '#type' => 'value',
  );
  $form['server_settings']['date_default_timezone']['#type'] = 'value';
  $form['server_settings']['update_status_module']['#default_value'] = array(0);
}


// "Inspired" by open atrium.
function foundation_profile_tasks(&$task, $url) {
  // Install profile api requires including the list of modules we install.
  install_include(foundation_profile_modules());
  $output = '';
  // We are running a batch task for this profile so basically do nothing and return page
  if (in_array($task, array('foundation-modules-batch', 'foundation-configure-batch'))) {
    include_once 'includes/batch.inc';
    $output = _batch_page();
  }

  $modules = _foundation_secondary_modules();
  $files = module_rebuild_cache();

  if ('profile' == $task) {
    foreach ($modules as $module) {
      $batch['operations'][] = array('_install_module_batch', array($module, $files[$module->info['name']]));
    }

    $batch['title'] = st('Installing @drupal', array('@drupal' => drupal_install_profile_name()));
    $batch['finished'] = '_foundation_module_batch_finished';
    $batch['error_message'] = st('The installation has encountered an error.');

    // Start a batch, switch to 'foundation-modules-batch' task. We need to
    // set the variable here, because batch_process() redirects.
    variable_set('install_task', 'foundation-modules-batch');
    batch_set($batch);
    batch_process($url, $url);
    // Jut for cli installs. We'll never reach here on interactive installs.
    return;
  }

  if ('profile-configure' == $task) {
    $batch['title'] = st('Configuring @drupal', array('@drupal' => drupal_install_profile_name()));
    $batch['operations'][] = array('_foundation_configure', array());
    $batch['finished'] = '_foundation_configure_finished';
    variable_set('install_task', 'foundation-configure-batch');
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
function _foundation_module_batch_finished($success, $results) {
  variable_set('install_task', 'profile-configure');
}

/**
 * First stage configuration, eg to create a taxonomy.
 */
function _foundation_configure() {
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
  variable_set('site_offline_message', 'This website is currently undergoing maintenance. We hope to be back shortly. Thank you for your patience.');

  // Add both user groups the permission to access content.
  install_add_permissions(1, array('access_content'));
  install_add_permissions(2, array('access_content'));

  $page_properties = array(
    'type' => 'page',
    'name' => 'Page',
    'description' => st("Add a static page to the site."),
  );
  install_add_content_type($page_properties);
  // Default page to not be promoted and have comments disabled.
  variable_set('node_options_page', array('status'));

  // Default themes are clean and clean_starter.
  _openatrium_system_theme_data();
  variable_set('theme_default', 'clean_starter');

  // install_enable_theme(array('clean', 'clean_starter'));
  // install_default_theme('clean');

  // Disable all DB blocks that got initialized until now.
  db_query("UPDATE {blocks} SET status = 0, region = ''");

  // Don't display date and author information for page nodes by default.
  $theme_settings = variable_get('theme_settings', array());
  $theme_settings['toggle_node_info_page'] = FALSE;
  variable_set('comment_page', COMMENT_NODE_DISABLED);
  variable_set('theme_settings', $theme_settings);
}

/**
 * Final stage of the configuration.
 */
function _foundation_configure_finished($success, $results) {
  variable_set('install_task', 'profile-finished');
}


/**
 * Copied from atrium installer profile.
 * Reimplementation of system_theme_data(). The core function's static cache
 * is populated during install prior to active install profile awareness.
 * This workaround makes enabling themes in profiles/[profile]/themes possible.
 */
function _openatrium_system_theme_data() {
  global $profile;
  $profile = 'foundation';

  $themes = drupal_system_listing('\.info$', 'themes');
  $engines = drupal_system_listing('\.engine$', 'themes/engines');

  $defaults = system_theme_default();

  $sub_themes = array();
  foreach ($themes as $key => $theme) {
    $themes[$key]->info = drupal_parse_info_file($theme->filename) + $defaults;

    if (!empty($themes[$key]->info['base theme'])) {
      $sub_themes[] = $key;
    }

    $engine = $themes[$key]->info['engine'];
    if (isset($engines[$engine])) {
      $themes[$key]->owner = $engines[$engine]->filename;
      $themes[$key]->prefix = $engines[$engine]->name;
      $themes[$key]->template = TRUE;
    }

    // Give the stylesheets proper path information.
    $pathed_stylesheets = array();
    foreach ($themes[$key]->info['stylesheets'] as $media => $stylesheets) {
      foreach ($stylesheets as $stylesheet) {
        $pathed_stylesheets[$media][$stylesheet] = dirname($themes[$key]->filename) .'/'. $stylesheet;
      }
    }
    $themes[$key]->info['stylesheets'] = $pathed_stylesheets;

    // Give the scripts proper path information.
    $scripts = array();
    foreach ($themes[$key]->info['scripts'] as $script) {
      $scripts[$script] = dirname($themes[$key]->filename) .'/'. $script;
    }
    $themes[$key]->info['scripts'] = $scripts;

    // Give the screenshot proper path information.
    if (!empty($themes[$key]->info['screenshot'])) {
      $themes[$key]->info['screenshot'] = dirname($themes[$key]->filename) .'/'. $themes[$key]->info['screenshot'];
    }
  }

  foreach ($sub_themes as $key) {
    $themes[$key]->base_themes = system_find_base_themes($themes, $key);
    // Don't proceed if there was a problem with the root base theme.
    if (!current($themes[$key]->base_themes)) {
      continue;
    }
    $base_key = key($themes[$key]->base_themes);
    foreach (array_keys($themes[$key]->base_themes) as $base_theme) {
      $themes[$base_theme]->sub_themes[$key] = $themes[$key]->info['name'];
    }
    // Copy the 'owner' and 'engine' over if the top level theme uses a
    // theme engine.
    if (isset($themes[$base_key]->owner)) {
      if (isset($themes[$base_key]->info['engine'])) {
        $themes[$key]->info['engine'] = $themes[$base_key]->info['engine'];
        $themes[$key]->owner = $themes[$base_key]->owner;
        $themes[$key]->prefix = $themes[$base_key]->prefix;
      }
      else {
        $themes[$key]->prefix = $key;
      }
    }
  }

  // Extract current files from database.
  system_get_files_database($themes, 'theme');
  db_query("DELETE FROM {system} WHERE type = 'theme'");
  foreach ($themes as $theme) {
    $theme->owner = !isset($theme->owner) ? '' : $theme->owner;
    db_query("INSERT INTO {system} (name, owner, info, type, filename, status, throttle, bootstrap) VALUES ('%s', '%s', '%s', '%s', '%s', %d, %d, %d)", $theme->name, $theme->owner, serialize($theme->info), 'theme', $theme->filename, isset($theme->status) ? $theme->status : 0, 0, 0);
  }
}