; Syntax: http://bit.ly/7rp6vM

; Essential site building starting kit.
; Drush Make API version
api = 2
; We are working with Drupal 6
core = 6.x

projects[] = drupal
;projects[pressflow][type] = "core"
;projects[pressflow][download][type] = "git"
;projects[pressflow][download][url] = git://github.com/bigmack83/pressflow-6.git

; Profile
projects[foundation][type] = "profile"
projects[foundation][download][type] = "git"
projects[foundation][download][url] = "git@github.com:psynaptic/foundation-profile.git"
projects[foundation][download][branch] = "profile-d6"

; Themes
projects[clean][subdir] = contrib
projects[clean][install_path] = sites/all
projects[clean_starter][type] = "theme"
projects[clean_starter][install_path] = sites/all
projects[clean_starter][download][type] = "git"
projects[clean_starter][download][url] = "git@github.com:psynaptic/clean_starter.git"

; Custom features
; projects[essential][subdir] = features
; projects[essential][download][type] = "git"
; projects[essential][download][url] = "git@github.com:psynaptic/feature-essential.git"

; Modules

; Administration
; Note: admin_menu v3 removes blocks from the /admin path.
; projects[admin][subdir] = contrib
; projects[admin][version] = 6.x-2.0-beta2
projects[admin_menu][subdir] = contrib
projects[admin_menu][install_path] = sites/all
projects[adminrole][subdir] = contrib
projects[adminrole][install_path] = sites/all

; CCK
projects[cck][subdir] = contrib
projects[cck][install_path] = sites/all
projects[filefield][subdir] = contrib
projects[filefield][install_path] = sites/all
projects[filefield_paths][subdir] = contrib
projects[filefield_paths][install_path] = sites/all
projects[imagefield][subdir] = contrib
projects[imagefield][install_path] = sites/all
projects[imageapi][subdir] = contrib
projects[imageapi][install_path] = sites/all
projects[imagecache][subdir] = contrib
projects[imagecache][install_path] = sites/all
projects[link][subdir] = contrib
projects[link][install_path] = sites/all
projects[email][subdir] = contrib
projects[email][install_path] = sites/all

; Other content
projects[node_clone][subdir] = contrib
projects[node_clone][install_path] = sites/all
projects[node_export][subdir] = contrib
projects[node_export][install_path] = sites/all
projects[flag][subdir] = contrib
projects[flag][install_path] = sites/all
projects[webform][subdir] = contrib
projects[webform][install_path] = sites/all
projects[panels][subdir] = contrib
projects[panels][install_path] = sites/all
projects[boxes][subdir] = contrib
projects[boxes][install_path] = sites/all
projects[views][subdir] = contrib
projects[views][install_path] = sites/all
projects[invisimail][subdir] = contrib
projects[invisimail][install_path] = sites/all

; Functional modules (improving usability, SEO etc)
projects[advanced_help][subdir] = contrib
projects[advanced_help][install_path] = sites/all
projects[token][subdir] = contrib
projects[token][install_path] = sites/all
projects[pathauto][subdir] = contrib
projects[pathauto][install_path] = sites/all
projects[blocks404][subdir] = contrib
projects[blocks404][install_path] = sites/all
projects[transliteration][subdir] = contrib
projects[transliteration][install_path] = sites/all
projects[poormanscron][subdir] = contrib
projects[poormanscron][install_path] = sites/all
projects[vertical_tabs][subdir] = contrib
projects[vertical_tabs][install_path] = sites/all
projects[fancy_contacts][subdir] = contrib
projects[fancy_contacts][install_path] = sites/all
projects[vt_default][subdir] = contrib
projects[vt_default][install_path] = sites/all
projects[filter_protocols][subdir] = contrib
projects[filter_protocols][install_path] = contrib
projects[markdown][subdir] = contrib
projects[markdown][install_path] = sites/all

; API modules
projects[ctools][subdir] = contrib
projects[ctools][install_path] = sites/all
projects[strongarm][subdir] = contrib
projects[strongarm][install_path] = sites/all
projects[features][subdir] = contrib
projects[features][install_path] = sites/all
projects[context][subdir] = contrib
projects[context][install_path] = sites/all

; Development related modules
projects[devel][subdir] = developer
projects[devel][install_path] = sites/all
projects[coder][subdir] = developer
projects[coder][install_path] = sites/all
projects[install_profile_api][subdir] = developer
projects[install_profile_api][install_path] = sites/all
projects[cvs_deploy][subdir] = developer
projects[cvs_deploy][install_path] = sites/all

; Performance modules
projects[views_content_cache][subdir] = contrib/performance
projects[views_content_cache][install_path] = sites/all
