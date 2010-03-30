#!/bin/sh
# Build script that edits the skeleton profile file and generates 
# a new one with project relevant details
# Example: 
# FRIENDLY_NAME="AP Installer"
# NAME will be a machine-friendly name generated (so it can be used in function names).

# Configuration
FRIENDLY_NAME="AP Installer"
DESCRIPTION="Install the AP website"

# Do not change these values.

machine_name() {
  # Lowercasing all and white space fix.
  echo "$1" | tr "[:upper:]" "[:lower:]" | tr "[:blank:]" "_"
}

NAME=`machine_name "$FRIENDLY_NAME"`
INPUT='essential.profile'
OUTPUT="$NAME.profile"

# Creating a backup
cp $INPUT $INPUT.old
# TODO the replace part is broken
# sed -i -r s/NAME/$NAME/ $INPUT
# sed -i -r s/FRIENDLY_NAME/$FRIENDLY_NAME/ $INPUT
# sed -i -r s/DESCRIPTION/$DESCRIPTION/ $INPUT

mv $INPUT $OUTPUT


