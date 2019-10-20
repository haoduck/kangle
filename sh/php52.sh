#!/bin/bash
files="/root/s-hell"
source $files/config
source $files/iver
rm -rf /root/p* /root/u* u* p*
PREFIX="/vhs/kangle/ext/tpl_php52"
phpv=`"$PREFIX"/bin/php -v |grep "$PHP52" -o`
file="php-$PHP52.tar.bz2"
ZEND_ARCH="i386"
LIB="lib"
force_install=$1
if test `arch` = "x86_64"; then
        LIB="lib64"
        ZEND_ARCH="x86_64"
fi
if [ "$PHP52" = "$phpv" ]&&[ "$force_install" != "force" ];
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
wget $DOWNLOAD_FILE_URL/file/php-$PHP52.tar.bz2 -O php-$PHP52.tar.bz2
tar xjf php-$PHP52.tar.bz2
cd php-$PHP52
}
else {
tar xjf php-$PHP52.tar.bz2
cd php-$PHP52
}
fi
patch -p1 < ./php5.2patch
CONFIG_CMD="./configure --prefix=$PREFIX --with-config-file-scan-dir=$PREFIX/etc/php.d --with-libdir=$LIB --enable-fastcgi --with-mysql --with-mysqli --with-pdo-mysql --with-iconv-dir --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr/include/libxml2/libxml --enable-xml --enable-bcmath --enable-inline-optimization --with-curl --with-curlwrappers --enable-mbregex --enable-mbstring --enable-ftp --with-gd --enable-gd-native-ttf --with-openssl --with-sockets --enable-sockets --with-xmlrpc --enable-zip --enable-soap --with-pear --with-gettext --enable-calendar"
if [ -f /usr/include/mcrypt.h ]; then
        CONFIG_CMD="$CONFIG_CMD --with-mcrypt --with-mhash-dir"
fi
$CONFIG_CMD
if test $? != 0; then
	echo $CONFIG_CMD
	echo -e "————————————————————————————————————————————————————
已检测您的系统安装PHP-$PHP52失败.
————————————————————————————————————————————————————";
	touch /root/$PHP52-erro
	exit 1
else
make
make install
mkdir -p $PREFIX/etc/php.d
echo "正在下载PHP5.2配置文件"
wget $DOWNLOAD_URL/config_file/php52.ini -O $PREFIX/php-templete.ini
wget $DOWNLOAD_URL/config_file/php52.xml -O $PREFIX/config.xml
wget -q $DOWNLOAD_URL/config_file/php52-node.ini -O $PREFIX/etc/php-node.ini

cd ..
#install zend
wget -q $DOWNLOAD_FILE_URL/file/zend-3.3.9-$ZEND_ARCH.tar.bz2 -O zend-3.3.9-$ZEND_ARCH.tar.bz2
tar xjf zend-3.3.9-$ZEND_ARCH.tar.bz2
cd zend-3.3.9-$ZEND_ARCH
mkdir -p $PREFIX/zend
rm -rf $PREFIX/zend/ZendOptimizer.so
mv ZendOptimizer.so $PREFIX/zend/ZendOptimizer.so
wget -q $DOWNLOAD_URL/config_file/zend-52.ini -O $PREFIX/etc/php.d/zend.ini
#install ioncube
wget -q $DOWNLOAD_FILE_URL/file/ioncube-$ZEND_ARCH-5.2.zip -O ioncube-$ZEND_ARCH-5.2.zip
unzip ioncube-$ZEND_ARCH-5.2.zip
mkdir -p $PREFIX/ioncube
rm -rf $PREFIX/ioncube/ioncube_loader_lin_5.2.so
mv -f ioncube_loader_lin_5.2.so $PREFIX/ioncube/ioncube_loader_lin_5.2.so
wget -q $DOWNLOAD_URL/config_file/ioncube-52.ini -O $PREFIX/etc/php.d/ioncube.ini

rm -rf /tmp/*
/vhs/kangle/bin/kangle
/vhs/kangle/bin/kangle -r
rm -rf php-$PHP52
echo -e "————————————————————————————————————————————————————
已检测您的系统成功安装PHP-$PHP52.谢谢您的使用
————————————————————————————————————————————————————"
exit 0
fi
}
fi
