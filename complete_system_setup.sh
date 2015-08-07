#!/bin/bash
clear;

# Validate if user is ROOT
if [[ $EUID -ne 0 ]]; then
  echo "*** Unfortunatly you must be a root user to run this script." 2>&1
  echo "Please login as ROOT and try this again." 2>&1
  exit 1
else
  echo "You will run this script as a ROOT." 2>&1
fi

#Setting variables
SCRIPTS_DIR="$(cd $(dirname $0) && pwd)"
TMP_DIR="/tmp/setup_script"
RPM_DIR=$SCRIPTS_DIR"/rpm"

# Load settings
source $SCRIPTS_DIR"/settings.sh"
echo "Get settings successfully" 2>&1

#creating tmp dir
mkdir -p $TMP_DIR
echo "Tmp dir "$TMP_DIR" created" 2>&1

# Update Operating System
cd $SCRIPTS_DIR
. system_update.sh
echo "Update Operating System successfully" 2>&1

# install Oracle
cd $SCRIPTS_DIR
. install_oracle.sh
echo "Oracle installed successfully" 2>&1


#removing tmp dir
rm -rf $TMP_DIR
echo "Tmp dir "$TMP_DIR" removed" 2>&1
echo ""

echo "Oracle version"
echo "xxxx"
echo ""


