See http://etherpad.com/jYccZqmNry for active documentation.

Naming convention

Basic idea is we should leave the site_name space clean to avoid any collisions, thus:

 * themename - <base_theme>_site_name (e.g. clean_axolotl_gallery)
 * custom modules: site_name_<name>

Install profile tasks
 * disable update status
 * remove unnecessary (all) form elements from the install profile so its easy to install (use same default user and password, which can be checked for in the testsuite later)
 * set config descriptions to short
 * set error reporting to screen
 * turn caching off (or is it off by def?)
 * create page content type
 * default page to not be promoted to frontpage
 * set default theme to clean starter and rename to site_name and replace Clean Starter in info file with Site Name Theme
 * set basic permissions to allow anon and auth users to by default be able to access and search content
 * disable default blocks (user 0, user 1, system 0)
 * set variables such as
   * date formats and timezones for UK
   * slogan, mission and offline message
   * disable admin theme


ESSENTIAL PROFILE:


clean

devel
coder
node_clone
node_export
install_profile_api
cvs_deploy
ctools
admin_menu
context
views
features
webform
token
panels
adminrole
cck
filefield
filefield_paths
imagefield
imageapi
imagecache
link
email
javascript_aggregator
vertical_tabs
block_edit
transliteration


NON-ESSENTIAL:


Development tools

views_bulk_operations
advanced_help

CCK modules

date, date api, date popup
emfield

Performance modules

cacherouter or boost < I use cacherouter
memcache

Content editing/management advanced modules

markdown
wysiwyg api with tinymce
checkall

SEO modules

pathauto
globalredirect
nodewords
page_title
google_analytics

SEO advanced

xmlsitemap < I never use this any more
custom_breadcrumbs

Social networking modules

addthis/sharethis/service_links or simpleshare http://github.com/developmentseed/simpleshare (which one is recommended?) < I need to try simpleshare! ;) it's by yhahn
fb/fb_connect

Spam

mollom
captcha

Ad hoc modules

custom_pagers
views_slideshow
extlink
shadowbox < shameless
denynodepath < shameless plug? hehe
admin - for clients on launch? ooooooooohhh nooooooooooooooooooooeeeeesssssssssssssss lol, probably tho



LATER:


Launch testing
Create a simpletest/site verification module (example: http://drupal.org/project/civicactions ) that checks for certain configuration options present, like:

 * update status enabled (it should be disabled during site build - by forcing it in the install profile!)
 * site email is set to correct client email
 * uid has correct name, email and strong password
 * development modules are disabled
 * error reporint to log and not to screen
 * files dir has correct perms
 * no errors on the status report screen
 * all files are in the files dir
 * is cache turned on, preprocess js and css enabled?
 * clean urls are on