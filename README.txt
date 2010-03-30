Essential profile is a starter kit for building custom sites. It tries to incorporate as many
commonly used building blocks and configurations as possible to jump-start a project.

Unfortunately some details in a project are always changing, like the name and description
of the installer item (as this installer is usually presented to the clients as well). In
order to do this automatically, these values are marked specially for a build script that is 
packaged with this profile.

Another issue is that drush make (currently) places all downloaded modules under profiles, which
is inconvenient for our current setup.

Build
=====

Run the build.sh and answer the questions regarding the project.
 - This will set the given variables in the profile, and rename the profile.
 - It will also move the modules and themes directory to sites/all.
 - It will prepare the installation by applying proper permissions to the settings.php and files.


What to do in the future
========================

Perhaps a more user-friendly build script that allows user input (GUI perhaps) then runs drush make.
E.g.:

./build.sh

Specify project name: 
Project description:

Custom projects: (-- this could automatically generate a makefile)
