#!/bin/bash
files="/root/s-hell"
PREFIX="/vhs/kangle"
source $files/config
source $files/iver
VERSION=$1
COMPLETED=$2

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

function setup_kangle_completed
{
	ARCH="6"
	if [ -f /usr/bin/systemctl ] ; then
		ARCH="7"
	fi
	if [ "$VERSION" = "" ]; then
		VERSION="$KANGLE_NEW_VERSION"
	fi
	if test `arch` = "x86_64"; then
		ARCH="$ARCH-x64"
	fi
	#http://download.cdnbest.com/ent/kangle-ent-3.4.8-6-x64.tar.gz
	#https://www.cdnbest.com/download/cdnbest/kangle-cdnbest-3.5.16.9-7-x64.tar.gz
	URL="$DOWNLOAD_FILE_URL/file/completed/kangle-ent-$VERSION-$ARCH.tar.gz"
	wget $URL -O kangle.tar.gz
	tar xzf kangle.tar.gz
	cd kangle
	mkdir -p $PREFIX
	wget $DOWNLOAD_URL/config_file/license.txt -O $PREFIX/license.txt
	./install.sh $PREFIX
}

function setup_kangle
{
	if [ "$VERSION" = "" ]; then
		VERSION="$KANGLE_VERSION"
	fi
	if [ -f /vhs/kangle/bin/kangle ] ; then
		K_LOCAL_VER=`/vhs/kangle/bin/kangle -v|grep -E "[0-9][.][0-9][.][0-9]" -o`
		if [ "$K_LOCAL_VER" == "" ] ; then 
			K_LOCAL_VER_TEMP=`/vhs/kangle/bin/kangle -v|grep -E "[/][0-9][.][0-9]" -o`
			K_LOCAL_VER=`echo $K_LOCAL_VER_TEMP|grep -E "[0-9][.][0-9]" -o`
		fi
		echo "k_local_ver="$K_LOCAL_VER
		echo "kangle_version="$VERSION
       		if [ "$K_LOCAL_VER" != "" ] ; then
               		check_ver $VERSION $K_LOCAL_VER
			check=$?
			if [ "$check" == 2 ] ; then
               		       echo "kangle check="$check
				 return;
            		fi
    		fi
	fi
	KANGLE_URL="file/kangle-$VERSION.tar.gz"
	if [  -f kangle-$VERSION.tar.gz ] ; then
		rm -f kangle-$VERSION.tar.gz
	fi	
	wget $DOWNLOAD_FILE_URL/$KANGLE_URL 
	if [ $? != 0 ] ; then
		exit $?
	fi
	tar xzf kangle-$VERSION.tar.gz
	cd kangle-$VERSION
	find|xargs touch
	./configure --prefix=$PREFIX --enable-vh-limit --enable-disk-cache --enable-ipv6 --enable-ssl --enable-http2
	if [ $? != 0 ] ; then
                 exit $?
        fi
	make
	if [ $? != 0 ] ; then
	         exit $?
	fi
	if [ -f "/vhs/kangle/bin/kangle" ];then
		/vhs/kangle/bin/kangle -q
		killall -9 kangle
		sleep 3
	fi
	make install
	if [ $? != 0 ] ; then
		exit $?
	else
		/vhs/kangle/bin/kangle
		echo "kangle-$VERSION is install success........................................................................................"
	fi
	cd -
}

if [ "$COMPLETED" = "1" ]; then
	setup_kangle_completed
else
	setup_kangle
fi

