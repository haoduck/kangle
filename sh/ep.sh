#!/bin/bash
files="/root/s-hell"
source $files/config
source $files/iver
PREFIX="/vhs/kangle"
DOWNLOAD_BASE_URL="http://download.kangleweb.com";
force_install=$1

SYS="x86"
if test `arch` = "x86_64"; then
	SYS="x86_64"
fi

LIBDIR="lib"
if test `arch` = "x86_64"; then
	LIBDIR="lib64"
fi

SYSVERSION="6"
if test `ldd --version|head -1|awk '{print $NF;}'` = "2.5" ; then
        SYSVERSION="5"
fi

rrr=''
function get_version
{
	a=`echo $1|grep -E "[0-9]+\.[0-9]+(\.[0-9]+)?" -o`
	x=`echo $a|grep -E "^[0-9]+" -o`
	y_temp=`echo $a|grep -E "\.[0-9]+(\.)?" -o`
	y=`echo $y_temp|grep -E "[0-9]+" -o`
	z=`echo $a|grep -E "[0-9]+$" -o`
	#r=$(( $(( x * 1000)) + $(( y * 100 )) + z ))
	r1=`expr $x \* 1000`
	r2=`expr $y \* 100`
	r=`expr $r1 \+ $r2 \+ $z`
	rrr=$r;
	return $r;
}
function check_ver
{
	get_version $1
	new=$rrr
	get_version $2
	old=$rrr
	if [ $new \> $old ] ; then
		return 1;
	fi
	return 2;
}

#setup easypanel
function setup_easypanel
{	
	#close selinux make  zend optimizer Effect
	setenforce 0
	sed -i '/SELINUX/s/enforcing/disabled/' /etc/selinux/config
	if [ "$force_install" != "force" ] && [ -f /vhs/kangle/nodewww/webftp/framework/runtime.php ] ; then
		E_LOCAL_VER=`cat /vhs/kangle/nodewww/webftp/framework/install.lock |grep -E "[.0-9]+" -o`
		if [ $E_LOCAL_VER != "" ] ; then
			echo "easypanel install version=$E_LOCAL_VER";
			echo "easypanel new version=$EASYPANEL_VERSION"
			check_ver $EASYPANEL_VERSION $E_LOCAL_VER
			easypanel_check=$?
       			if [ "$easypanel_check" == 2 ] ; then
               			echo "easypanel check=$easypanel_check"
				return;
     	 		fi
		fi
	fi
	# chmod 700 $PREFIX/etc $PREFIX/var $PREFIX/nodewww/data	
	rm -rf easypanel-$EASYPANEL_VERSION-$SYS
	rm -rf easypanel-$EASYPANEL_VERSION-$SYS-$SYSVERSION.tar.gz
	EASYPANEL_URL="$DOWNLOAD_FILE_URL/file/completed/easypanel-$EASYPANEL_VERSION-$SYS-$SYSVERSION.tar.gz"
	EA_FILE_NAME="easypanel-$EASYPANEL_VERSION-$SYS-$SYSVERSION.tar.gz"
	wget $EASYPANEL_URL -O $EA_FILE_NAME -c
	if [ $? != 0 ] ; then
        	exit $?
	fi
	
	tar xzf $EA_FILE_NAME
	if [ $? != 0 ] ; then
        	exit $?
	fi
	/vhs/kangle/bin/kangle -q
	killall php-cgi
	\cp -a easypanel-$EASYPANEL_VERSION-$SYS/* /vhs/kangle/
	if [ -d $PREFIX/nodewww/webftp/dns ] ; then
		rm -rf $PREFIX/nodewww/webftp/dns
	fi
	/vhs/kangle/bin/kangle
	if [ $? != 0 ] ; then
       		 exit $?
	fi

	if [ -f /vhs/kangle/etc/kanglestat ] ; then
		if [ ! -f /etc/init.d/kangle ] ; then
			\cp /vhs/kangle/etc/kanglestat /etc/init.d/kangle
		fi
		if [ ! -f /etc/rc.d/rc3.d/S66kangle ] ; then
			ln -s /etc/init.d/kangle /etc/rc.d/rc3.d/S66kangle
		        ln -s /etc/init.d/kangle /etc/rc.d/rc5.d/S66kangle
		fi
	fi

	# 1.6.3 add mysql && mysqldump to /vhs/kangle/bin
	if [ ! -f /vhs/kangle/bin/mysql ] ; then
                ln -s /usr/bin/mysql /vhs/kangle/bin/mysql
        fi
        if [ ! -f /vhs/kangle/bin/mysqldump ] ; then
                ln -s /usr/bin/mysqldump /vhs/kangle/bin/mysqldump
        fi
        if [ ! -f /vhs/kangle/bin/wget ] ; then
                ln -s /usr/bin/wget /vhs/kangle/bin/wget
        fi

	echo "easypanel-$EASYPANEL_VERSION-$SYS-$SYSVERSION setup success.............................................................................."
}
function setup_webalizer
{
	if [ ! -f /usr/bin/webalizer ] ; then
		yum -y install webalizer
	fi
	chkconfig httpd off
	chkconfig nginx off
	return;
}

service httpd stop
service nginx stop
mkdir tmp
cd tmp
setup_easypanel php53
setup_webalizer

wget  http://localhost:3312/upgrade.php -O /dev/null -q
echo "

"