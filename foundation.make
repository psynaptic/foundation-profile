; Syntax: http://bit.ly/7rp6vM

; Essential site building starting kit.
core = 6.x

projects[] = drupal
;projects[pressflow][type] = "core"
;projects[pressflow][download][type] = "git"
;projects[pressflow][download][url] = git://github.com/bigmack83/pressflow-6.git

; Profile
projects[foundation][type] = "profile"
projects[foundation][download][type] = "git"
projects[foundation][download][url] = "git@dev.freestylesystems.co.uk:foundation"

; Themes
projects[clean][subdir] = contrib
projects[clean][install_path] = sites/all
projects[clean_starter][type] = "theme"
projects[clean_starter][install_path] = sites/all
projects[clean_starter][download][type] = "git"
projects[clean_starter][download][url] = "git@dev.freestylesystems.co.uk:clean_starter"

; Custom features
; projects[essential][subdir] = features
; projects[essential][download][type] = "git"
; projects[essential][download][url] = "git@dev.freestylesystems.co.uk:essential"

; Modules

; Administration
; Note: admin_menu v3 removes blocks from the /admin path.
; projects[admin][subdir] = contrib
; projects[admin][version] = 6.x-2.0-beta2
projects[admin_menu][subdir] = contrib
projects[admin_menu][install_path] = sites/all
projects[adminrole][subdir] = contrib
projects[adminrole][install_path] = sites/all

; Content
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
projects[node_clone][subdir] = contrib
projects[node_clone][install_path] = sites/all
projects[node_export][subdir] = contrib
projects[node_export][install_path] = sites/all
projects[webform][subdir] = contrib
projects[webform][install_path] = sites/all
projects[panels][subdir] = contrib
projects[panels][install_path] = sites/all
projects[boxes][subdir] = contrib
projects[boxes][install_path] = sites/all
projects[views][subdir] = contrib
projects[views][install_path] = sites/all

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

