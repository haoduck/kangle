#!/bin/bash
files="/root/s-hell"
source $files/config
source $files/iver
rm -rf /root/p* /root/u* u* p*
PREFIX="/vhs/kangle/ext/php71"
phpv=`"$PREFIX"/bin/php -v |grep "$PHP71" -o`
file="php-$PHP71.tar.bz2"
ZEND_ARCH="i386"
LIB="lib"
force_install=$1

if test `arch` = "x86_64"; then
        LIB="lib64"
        ZEND_ARCH="x86_64"
fi
if [ "$PHP71" = "$phpv" ]&&[ "$force_install" != "force"  ];
then {
clear
echo -e "————————————————————————————————————————————————————
检测到您已安装了 PHP-"$phpv" 
不需要重复再次编译安装
————————————————————————————————————————————————————"
exit 1
}
else
{
if [ ! -s "$file" ];
then {
wget $DOWNLOAD_FILE_URL/file/php-$PHP71.tar.bz2 -O php-$PHP71.tar.bz2
tar xjf php-$PHP71.tar.bz2
}
else {

tar xjf php-$PHP71.tar.bz2
}
fi
cd php-$PHP71
CONFIG_CMD="./configure --prefix=$PREFIX --with-config-file-scan-dir=$PREFIX/etc/php.d --with-libdir=$LIB --enable-fastcgi --enable-mysqlnd --with-mysql-sock=/var/run/mysql/mysql.sock --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-iconv-dir --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr/include/libxml2/libxml --enable-xml --enable-bcmath --enable-inline-optimization --with-curl --with-curlwrappers --enable-mbregex --enable-mbstring --enable-ftp --with-gd --enable-gd-native-ttf --with-openssl --with-sockets --enable-sockets --with-xmlrpc --enable-zip --enable-soap --with-pear --with-gettext --enable-calendar --with-mhash --enable-opcache"
if [ -f /usr/include/mcrypt.h ]; then
        CONFIG_CMD="$CONFIG_CMD --with-mcrypt"
fi
$CONFIG_CMD
if test $? != 0; then
{
	echo $CONFIG_CMD
		echo -e "————————————————————————————————————————————————————
已检测您的系统安装PHP-$PHP71失败.
————————————————————————————————————————————————————";
exit 1
}
else
{
make
make install
mkdir -p $PREFIX/etc/php.d
echo "正在下载PHP7配置文件"
wget -q $DOWNLOAD_URL/config_file/php71.xml -O $PREFIX/config.xml
wget -q $DOWNLOAD_URL/config_file/php71.ini -O $PREFIX/php-templete.ini
#install ioncube
echo "正在下载ioncube组件"
wget -q $DOWNLOAD_FILE_URL/file/ioncube-$ZEND_ARCH-7.1.zip
echo "正在解压文件"
unzip ioncube-$ZEND_ARCH-7.1.zip
echo "正在安装ioncube组件"
mkdir -p $PREFIX/ioncube
rm -rf $PREFIX/ioncube/ioncube_loader_lin_7.1.so
mv -f ioncube_loader_lin_7.1.so $PREFIX/ioncube/ioncube_loader_lin_7.1.so
echo "ioncube组件安装完成"
#install SourceGuardian
wget $DOWNLOAD_FILE_URL/file/ixed-$ZEND_ARCH-7.1.zip -O ixed-$ZEND_ARCH-7.1.zip
unzip ixed-$ZEND_ARCH-7.1.zip
mkdir -p $PREFIX/ixed
mv -f ixed.7.1.lin $PREFIX/ixed/ixed.7.1.lin

echo "正在清理编译后的垃圾"
rm -rf /tmp/*
/vhs/kangle/bin/kangle -r
rm -rf php-$PHP71
echo -e "————————————————————————————————————————————————————
已检测您的系统成功安装PHP-$PHP71.谢谢您的使用
————————————————————————————————————————————————————"
}
fi
}
fi
