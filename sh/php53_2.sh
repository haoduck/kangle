#!/bin/bash
files="/root/s-hell"
source $files/config
source $files/iver
rm -rf /root/p* /root/u* u* p*
PREFIX="/vhs/kangle/ext/php53"
phpv=`"$PREFIX"/bin/php -v |grep "$PHP53" -o`
file="php-$PHP53.tar.bz2"
file2="config.xml"
ZEND_ARCH="i386"
LIB="lib"
force_install=$1
if test `arch` = "x86_64"; then
        LIB="lib64"
        ZEND_ARCH="x86_64"
fi
if [ "$PHP53" = "$phpv" ]&&[ "$force_install" != "force"  ];
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
yum -y install patch
if [ ! -s "$file" ];
then {
wget $DOWNLOAD_FILE_URL/file/php-$PHP53.tar.bz2 -O php-$PHP53.tar.bz2
tar xjf php-$PHP53.tar.bz2
}
else {
tar xjf php-$PHP53.tar.bz2
}
fi
cd php-$PHP53
wget $DOWNLOAD_URL/config_file/php5.3patch -O php5.3patch
patch -p1 < ./php5.3patch
CONFIG_CMD="./configure --prefix=$PREFIX --with-config-file-scan-dir=$PREFIX/etc/php.d --with-libdir=$LIB --enable-fastcgi --with-mysql --with-mysqli --with-pdo-mysql --with-iconv-dir --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr/include/libxml2/libxml --enable-xml --enable-bcmath --enable-inline-optimization --with-curl --with-curlwrappers --enable-mbregex --enable-mbstring --enable-ftp --with-gd --enable-gd-native-ttf --with-openssl --with-sockets --enable-sockets --with-xmlrpc --enable-zip --enable-soap --with-pear --with-gettext --enable-calendar"
if [ -f /usr/include/mcrypt.h ]; then
        CONFIG_CMD="$CONFIG_CMD --with-mcrypt --with-mhash-dir"
fi
$CONFIG_CMD
if test $? != 0; then
	echo $CONFIG_CMD
		echo -e "————————————————————————————————————————————————————
已检测您的系统安装PHP-$PHP53失败.
————————————————————————————————————————————————————";
	touch /root/$PHP53-erro
	exit 1
else
make
make install
mkdir -p $PREFIX/etc/php.d
wget $DOWNLOAD_URL/config_file/php53.ini -O $PREFIX/php-templete.ini
wget $DOWNLOAD_URL/config_file/php53.xml -O $PREFIX/config.xml
wget -q $DOWNLOAD_URL/config_file/nodephp.xml -O $PREFIX/config.xml
wget -q $DOWNLOAD_URL/config_file/php-node.ini -O $PREFIX/etc/php-node.ini

#install zend
wget $DOWNLOAD_FILE_URL/file/zend-php53-$ZEND_ARCH.tar.bz2 -O zend-php53-$ZEND_ARCH.tar.bz2
tar xjf zend-php53-$ZEND_ARCH.tar.bz2
cd zend-php53-$ZEND_ARCH
mkdir -p $PREFIX/zend
rm -rf $PREFIX/zend/ZendGuardLoader.so
mv -f ZendGuardLoader.so $PREFIX/zend/ZendGuardLoader.so
#install ioncube
wget $DOWNLOAD_FILE_URL/file/ioncube-$ZEND_ARCH-5.3.zip -O ioncube-$ZEND_ARCH-5.3.zip
unzip ioncube-$ZEND_ARCH-5.3.zip
mkdir -p $PREFIX/ioncube
rm -rf $PREFIX/ioncube/ioncube_loader_lin_5.3.so
mv -f ioncube_loader_lin_5.3.so $PREFIX/ioncube/ioncube_loader_lin_5.3.so
#install SourceGuardian
wget $DOWNLOAD_FILE_URL/file/ixed-$ZEND_ARCH-5.3.zip -O ixed-$ZEND_ARCH-5.3.zip
unzip ixed-$ZEND_ARCH-5.3.zip
mkdir -p $PREFIX/ixed
mv -f ixed.5.3.lin $PREFIX/ixed/ixed.5.3.lin

rm -rf /tmp/*
/vhs/kangle/bin/kangle
/vhs/kangle/bin/kangle -r
rm -rf php-$PHP53
echo -e "————————————————————————————————————————————————————
已检测您的系统成功安装PHP-$PHP53.谢谢您的使用
————————————————————————————————————————————————————"
exit 0
fi
}
fi
