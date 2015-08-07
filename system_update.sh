#!/bin/bash

clear
echo "*********************************************************************************"
echo "*********************************************************************************"
echo "******************************    Update Oracle Server    ************************"
echo "*********************************************************************************"
echo "*********************************************************************************"
echo "This script is intended to:"
echo " 1. Update Operating System"
echo "*********************************************************************************"

# Validate if user is ROOT
if [[ $EUID -ne 0 ]]; then
  echo "*** Unfortunatly you must be a root user to run this script." 2>&1
  echo "Please login as ROOT and try this again." 2>&1
  exit 1
else
  echo "You will run this script as a ROOT." 2>&1
fi

#fix host file
$SCRIPTS_DIR/tools/etchosts.sh update $(hostname) 127.0.0.1


#####################################################################################
# Update System
#####################################################################################
yum install -y yum-priorities
yum -y clean metadata
yum -y clean all
yum -y update

#Install common stuff
yum install -y yum-plugin-replace
yum install -y wget
yum install -y rpm-build
yum install -y make
yum install -y gcc
yum install -y svn
yum install -y expect
yum install -y send
