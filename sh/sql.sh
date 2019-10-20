#!/bin/bash
files="/root/s-hell"
source $files/config
source $files/iver

User="root"
Db="mysql"
Pass=$1
if [ "$Pass" = "" ]; then
Pass="mysql"
fi

#killall mysqld
yum -y install mysql mysql-common mysql-libs mysql-devel mysql-server
rm -rf /var/lib/mysql/ibdata1
rm -rf /var/lib/mysql/ib_logfile0
rm -rf /var/lib/mysql/ib_logfile1
service mysqld restart
chkconfig --level 2345 mysqld on
wget -q $DOWNLOAD_URL/config_file/my.cnf -O /etc/my.cnf
#重置MySQL密码与修正MySQL升级后的bug
wget -q $DOWNLOAD_URL/sh/reset.sh -O reset.sh;sh reset.sh $Pass
mysql_upgrade -uroot mysql
service mysqld restart
#mysql -u$User -p$Pass -D $Db -e "ALTER TABLE user ADD Create_tablespace_priv ENUM('N','Y') NOT NULL DEFAULT 'N' AFTER Trigger_priv;"
#mysql -u$User -p$Pass -D $Db -e "ALTER TABLE user ADD plugin CHAR(64) NULL AFTER max_user_connections;"
#mysql -u$User -p$Pass -D $Db -e "ALTER TABLE user ADD authentication_string TEXT NULL DEFAULT NULL AFTER plugin;"
#mysql -u$User -p$Pass -D $Db -e "ALTER TABLE user ADD password_expired ENUM('N','Y') NOT NULL DEFAULT 'N' AFTER authentication_string;"
#service mysqld restart
