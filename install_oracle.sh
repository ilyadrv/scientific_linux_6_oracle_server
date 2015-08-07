#!/bin/bash

echo "*********************************************************************************"
echo "*********************************************************************************"
echo "******************************    Install Oracle         ************************"
echo "*********************************************************************************"
echo "*********************************************************************************"
echo "This script is intended to:"
echo " 1. Install Oracle"
echo "*********************************************************************************"


#instal libraries
yum install -y libaio bc flex net-tools

#install oracle
cd $RPM_DIR
rpm -Uvh oracle-instantclient11.2-basic-11.2.0.4.0-1.x86_64.rpm
rpm -Uvh oracle-instantclient11.2-devel-11.2.0.4.0-1.x86_64.rpm
cd $RPM_DIR"/oracle"
rpm -Uvh oracle-xe-11.2.0-1.0.x86_64.rpm

#configure oracle
expect << EOF
spawn /etc/init.d/oracle-xe configure

set timeout -1
expect "*HTTP port*" { send "\r" }
expect "*port*listener*" { send "\r" }
expect "*password*" { send $ORA_SYS_PASS\r }
expect "*password*" { send $ORA_SYS_PASS\r }
expect "*started on boot*" { send "y\r" }
expect "#" { send "\r" }
EOF

# init odacle env and add it to bashrc
source /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh
echo "source /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh"  >> ~/.bashrc

#add user
sqlplus sys/$ORA_SYS_PASS as SYSDBA <<EOF
create user $ORA_DUO_USER_LOGIN identified by $ORA_DUO_USER_PASS;
grant connect, resource, create any view to $ORA_DUO_USER_LOGIN;
EOF