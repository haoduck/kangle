#!/bin/bash
files="/root/s-hell"
source $files/config
source $files/iver
rm -rf /root/p* /root/u* u* p*
PREFIX="/vhs/kangle/ext/php56"
phpv=`"$PREFIX"/bin/php -v |grep "$PHP56" -o`
file="php-$PHP56.tar.bz6"
ZEND_ARCH="i386"
LIB="lib"
force_install=$1

if test `arch` = "x86_64"; then
        LIB="lib64"
        ZEND_ARCH="x86_64"
fi
if [ "$PHP56" = "$phpv" ]&&[ "$force_install" != "force"  ];
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
wget $DOWNLOAD_FILE_URL/file/php-$PHP56.tar.bz2 -O php-$PHP56.tar.bz2
tar xjf php-$PHP56.tar.bz2
}
else {

tar xjf php-$PHP56.tar.bz2
}
fi
cd php-$PHP56
CONFIG_CMD="./configure --prefix=$PREFIX --with-config-file-scan-dir=$PREFIX/etc/php.d --with-libdir=$LIB --enable-fastcgi --with-mysql --with-mysqli --with-pdo-mysql --with-iconv-dir --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr/include/libxml2/libxml --enable-xml --enable-bcmath --enable-inline-optimization --with-curl --with-curlwrappers --enable-mbregex --enable-mbstring --enable-ftp --with-gd --enable-gd-native-ttf --with-openssl --with-sockets --enable-sockets --with-xmlrpc --enable-zip --enable-soap --with-pear --with-gettext --enable-calendar --enable-opcache"
if [ -f /usr/include/mcrypt.h ]; then
        CONFIG_CMD="$CONFIG_CMD --with-mcrypt --with-mhash-dir"
fi
$CONFIG_CMD
if test $? != 0; then
echo $CONFIG_CMD
	echo -e "————————————————————————————————————————————————————
已检测您的系统安装PHP-$PHP56失败.
————————————————————————————————————————————————————";
touch /root/$PHP56-erro
exit 1
else
make
make install
mkdir -p $PREFIX/etc/php.d
wget $DOWNLOAD_URL/config_file/php56.xml -O $PREFIX/config.xml
wget $DOWNLOAD_URL/config_file/php56.ini -O $PREFIX/php-templete.ini

#install zend
wget $DOWNLOAD_FILE_URL/file/zend-loader-php5.6-linux-$ZEND_ARCH.tar.gz
tar zxf zend-loader-php5.6-linux-$ZEND_ARCH.tar.gz
cd zend-loader-php5.6-linux-$ZEND_ARCH
mkdir -p $PREFIX/zend
rm -rf $PREFIX/zend/ZendGuardLoader.so
rm -rf $PREFIX/zend/opcache.so
mv -f ZendGuardLoader.so $PREFIX/zend/ZendGuardLoader.so
mv -f opcache.so $PREFIX/zend/opcache.so
#install ioncube
wget $DOWNLOAD_FILE_URL/file/ioncube-$ZEND_ARCH-5.6.zip
unzip ioncube-$ZEND_ARCH-5.6.zip
mkdir -p $PREFIX/ioncube
rm -rf $PREFIX/ioncube/ioncube_loader_lin_5.6.so
mv -f ioncube_loader_lin_5.6.so $PREFIX/ioncube/ioncube_loader_lin_5.6.so
#install SourceGuardian
wget $DOWNLOAD_FILE_URL/file/ixed-$ZEND_ARCH-5.6.zip -O ixed-$ZEND_ARCH-5.6.zip
unzip ixed-$ZEND_ARCH-5.6.zip
mkdir -p $PREFIX/ixed
mv -f ixed.5.6.lin $PREFIX/ixed/ixed.5.6.lin

rm -rf /tmp/*
/vhs/kangle/bin/kangle
/vhs/kangle/bin/kangle -r
rm -rf php-$PHP56
echo -e "————————————————————————————————————————————————————
已检测您的系统成功安装PHP-$PHP56.谢谢您的使用
————————————————————————————————————————————————————"
exit 0
fi
}
fi
