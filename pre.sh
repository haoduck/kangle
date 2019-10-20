#!/bin/bash
files="/root/s-hell"
source $files/config
source $files/iver
install_mysql=$1
rm -rf hlsh* dns* ots* 
centos6="release 6."
centos7="release 7."
OS6=`cat /etc/redhat-release |grep "$centos6" -o`
OS7=`cat /etc/redhat-release |grep "$centos7" -o`
if [ "$OS6" = "$centos6" ]||[ "$OS7" = "$centos7" ]; then
clear

echo -e "————————————————————————————————————————————————————
	\033[1mＫＡＮＧＬＥＳＯＦＴ\033[0m
	\033[32mKangle一键脚本-开始安装\033[0m
————————————————————————————————————————————————————"

#设置MySQL密码
if [ "$install_mysql" != "no" ]; then
	mysql_root_password=""
	read -p "请输入您需要设置的MySQL密码:" mysql_root_password
	if [ "$mysql_root_password" = "" ]; then
	mysql_root_password="mysql"
	fi
	echo '[OK] Your MySQL password is:';
	echo $mysql_root_password;
else
	mysql_root_password="no"
fi

echo -e "———————————————————————————
   \033[32mKangle版本选择(极速安装均为商业版)\033[0m
1. 极速安装 Kangle 3.5.17 最新版(推荐)
2. 极速安装 Kangle 3.5.16 开发版
3. 编译安装 Kangle 3.5.16 开发版
4. 极速安装 Kangle 3.4.8 经典版
5. 编译安装 Kangle 3.4.8 经典版"
read -p "请输入序号并回车:" YORN
if [ "$YORN" = "2" ]; then
kangle_var="$KANGLE_ENT_VERSION";
kangle_completed="1";
elif [ "$YORN" = "3" ]; then
kangle_var="$KANGLE_VERSION";
kangle_completed="0";
elif [ "$YORN" = "4" ]; then
kangle_var="$KANGLE_OLD_VERSION";
kangle_completed="1";
elif [ "$YORN" = "4" ]; then
kangle_var="$KANGLE_OLD_VERSION";
kangle_completed="0";
else
kangle_var="$KANGLE_NEW_VERSION";
kangle_completed="1";
fi

echo -e "———————————————————————————
   \033[32mPHP版本选择\033[0m
1. 极速安装 PHP5.3-7.3(推荐)
2. 极速安装 PHP5.3
3. 编译安装 PHP5.3-7.3
4. 编译安装 PHP5.3"
read -p "请输入序号并回车:" YORN
if [ "$YORN" = "2" ]; then
select_var="default";
elif [ "$YORN" = "3" ]; then
select_var="allc";
elif [ "$YORN" = "4" ]; then
select_var="defaultc";
else
select_var="all";
fi

echo -e "
————————————————————————————————————————————————————
	Kangle一键脚本检测系统！
————————————————————————————————————————————————————
您的系统为 \033[32mCentos\033[0m $P5$P6 系列
正在继续获取YUM组件安装
————————————————————————————————————————————————————"

yum -y upgrade ca-certificates --disablerepo=epel

isC7=`cat /etc/redhat-release |grep ' 7.'`
if [ "${isC7}" == "" ];then
	yum_repos_s=`ls /etc/yum.repos.d | wc -l`;
	if [ "$yum_repos_s" == '0' ]; then
		wget -q $DOWNLOAD_FILE_URL/repo/Centos-6.repo -O /etc/yum.repos.d/CentOS-Base.repo
		rpm -ivh $DOWNLOAD_FILE_URL/repo/epel-release-latest-6.noarch.rpm --nodeps --force
		#sed -i "s/mirrorlist=https/mirrorlist=http/" /etc/yum.repos.d/epel.repo
	fi;
	epel_repos_s=`ls /etc/yum.repos.d | grep epel -i | wc -l`;
	if [ "$epel_repos_s" == '0' ]; then
		rpm -ivh $DOWNLOAD_FILE_URL/repo/epel-release-latest-6.noarch.rpm --nodeps --force
		#sed -i "s/mirrorlist=https/mirrorlist=http/" /etc/yum.repos.d/epel.repo
	fi;
	rpm -ivh $DOWNLOAD_FILE_URL/repo/mysql-community-release-el6-5.noarch.rpm --nodeps --force
	wget -q $DOWNLOAD_FILE_URL/repo/mysql-community.repo?v=1001 -O /etc/yum.repos.d/mysql-community.repo
else
	yum_repos_s=`ls /etc/yum.repos.d | wc -l`;
	if [ "$yum_repos_s" == '0' ]; then
		wget -q $DOWNLOAD_FILE_URL/repo/Centos-7.repo -O /etc/yum.repos.d/CentOS-Base.repo
		rpm -ivh $DOWNLOAD_FILE_URL/repo/epel-release-latest-7.noarch.rpm --nodeps --force
		#sed -i "s/mirrorlist=https/mirrorlist=http/" /etc/yum.repos.d/epel.repo
	fi;
	epel_repos_s=`ls /etc/yum.repos.d | grep epel -i | wc -l`;
	if [ "$epel_repos_s" == '0' ]; then
		rpm -ivh $DOWNLOAD_FILE_URL/repo/epel-release-latest-7.noarch.rpm --nodeps --force
		#sed -i "s/mirrorlist=https/mirrorlist=http/" /etc/yum.repos.d/epel.repo
	fi;
	rpm -ivh $DOWNLOAD_FILE_URL/repo/mysql-community-release-el7-5.noarch.rpm --nodeps --force
	wget -q $DOWNLOAD_FILE_URL/repo/mysql-community.repo?v=1001 -O /etc/yum.repos.d/mysql-community.repo
fi

yum clean all
yum makecache
yum -y remove httpd php mysql mysql-server php-mysql mysql-libs mysql-devel mysql-common MariaDB-server MariaDB-client;
yum -y install yum-fastestmirror epel-release
#yum -y update
yum -y install make automake cmake patch gcc gcc-c++ zip unzip quota autoconf ntp expect bison flex cron
yum -y install pcre pcre-devel zlib zlib-devel sqlite sqlite-devel mhash mhash-devel bzip2 bzip2-devel gd libtool-libs
yum -y install libtool-ltdl libtool-ltdl-devel libjpeg-devel libpng-devel freetype freetype-devel
yum -y install libxml2-devel curl curl-devel libxslt-devel db4-devel readline-devel glibc-devel glibc-static glib2-devel gettext-devel libcap-devel
yum -y install mhash mcrypt libmcrypt libmcrypt-devel openssl openssl-devel libaio-devel
yum -y install mysql-common mysql-libs
clear
echo
\cp -a -r /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
echo 'Synchronizing system time...'
ntpdate 0.asia.pool.ntp.org
ulimit -n 1048576
echo "* soft nofile 1048576" >> /etc/security/limits.conf
echo "* hard nofile 1048576" >> /etc/security/limits.conf
clear
echo -e "
————————————————————————————————————————————————————
您的系统已完成YUM组件安装.正在继续进行Kangle安装
————————————————————————————————————————————————————"
wget -q $DOWNLOAD_URL/install.sh -O install.sh;sh install.sh $kangle_var $kangle_completed $select_var $mysql_root_password | tee $files/install.log
else
clear
echo -e "
————————————————————————————————————————————————————
您的系统不是 Centos 6/7 系列 无法安装 请更换系统
————————————————————————————————————————————————————"
exit 1
fi


