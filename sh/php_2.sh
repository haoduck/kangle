#!/bin/bash
files="/root/s-hell"
source $files/config
source $files/iver
PREFIX="/vhs/kangle/ext/"
intallphpv=$1
force_install=$2
SYS="x86"
if test `arch` = "x86_64"; then
	SYS="x86_64"
fi
ARCH="6"
if [ -f /usr/bin/systemctl ] ; then
	ARCH="7"
fi

if [ "$intallphpv" = "php52" ];then
	php_version="$PHP52"
	php_dir="tpl_php52"
elif [ "$intallphpv" = "php53" ];then
	php_version="$PHP53"
	php_dir="php53"
elif [ "$intallphpv" = "php54" ];then
	php_version="$PHP54"
	php_dir="php54"
elif [ "$intallphpv" = "php55" ];then
	php_version="$PHP55"
	php_dir="php55"
elif [ "$intallphpv" = "php56" ];then
	php_version="$PHP56"
	php_dir="php56"
elif [ "$intallphpv" = "php70" ];then
	php_version="$PHP7"
	php_dir="php70"
elif [ "$intallphpv" = "php71" ];then
	php_version="$PHP71"
	php_dir="php71"
elif [ "$intallphpv" = "php72" ];then
	php_version="$PHP72"
	php_dir="php72"
elif [ "$intallphpv" = "php73" ];then
	php_version="$PHP73"
	php_dir="php73"

if [ ! -s /usr/lib64/libzip.so.5 ]; then
yum -y remove libzip libzip-devel
wget --no-check-certificate -O libzip-1.3.2.tar.gz $DOWNLOAD_FILE_URL/file/libzip-1.3.2.tar.gz
tar xvf libzip-1.3.2.tar.gz
cd libzip-1.3.2
./configure
make
make install
ln -s /usr/local/lib/libzip.so.5 /usr/lib64/libzip.so.5
fi

else
	echo -e "————————————————————————————————————————————————————
未指定安装的PHP版本
————————————————————————————————————————————————————"
exit 1
fi

phpv=`"$PREFIX$php_dir"/bin/php -v |grep "$php_version" -o`
file="php-$php_version-$ARCH-$SYS.tar.bz2"

if [ "$php_version" = "$phpv" ]&&[ "$force_install" != "force" ];
then {
clear
echo -e "————————————————————————————————————————————————————
检测到您已安装了 PHP-"$php_version" 
不需要重复再次安装
————————————————————————————————————————————————————"
exit 1
}
else
{
wget -c $DOWNLOAD_FILE_URL/file/completed/$file -O $file
echo -e "正在解压缩文件"
tar -xjf $file
/vhs/kangle/bin/kangle -q
echo -e "正在安装文件"
rm -rf $PREFIX$php_dir
mv -f $php_dir $PREFIX
rm -rf /tmp/*
/vhs/kangle/bin/kangle --reboot
echo -e "————————————————————————————————————————————————————
已检测您的系统成功安装PHP-$php_version.谢谢您的使用
————————————————————————————————————————————————————"
}
fi
