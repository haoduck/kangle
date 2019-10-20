#!/bin/bash
files="/root/s-hell"
source $files/config

PREFIX="/vhs/kangle/ext/tpl_php52"
if [ -d "$PREFIX" ];then
wget $DOWNLOAD_URL/config_file/php52.ini -O $PREFIX/php-templete.ini
wget $DOWNLOAD_URL/config_file/php52-node.ini -O $PREFIX/etc/php-node.ini
fi
PREFIX="/vhs/kangle/ext/php53"
if [ -d "$PREFIX" ];then
wget $DOWNLOAD_URL/config_file/php53.ini -O $PREFIX/php-templete.ini
wget $DOWNLOAD_URL/config_file/php-node.ini -O $PREFIX/etc/php-node.ini
fi
PREFIX="/vhs/kangle/ext/php54"
if [ -d "$PREFIX" ];then
wget $DOWNLOAD_URL/config_file/php54.ini -O $PREFIX/php-templete.ini
wget $DOWNLOAD_URL/config_file/php-node.ini -O $PREFIX/etc/php-node.ini
fi
PREFIX="/vhs/kangle/ext/php55"
if [ -d "$PREFIX" ];then
wget $DOWNLOAD_URL/config_file/php55.ini -O $PREFIX/php-templete.ini
wget $DOWNLOAD_URL/config_file/php-node.ini -O $PREFIX/etc/php-node.ini
fi
PREFIX="/vhs/kangle/ext/php56"
if [ -d "$PREFIX" ];then
wget $DOWNLOAD_URL/config_file/php56.ini -O $PREFIX/php-templete.ini
wget $DOWNLOAD_URL/config_file/php-node.ini -O $PREFIX/etc/php-node.ini
fi
PREFIX="/vhs/kangle/ext/php70"
if [ -d "$PREFIX" ];then
wget $DOWNLOAD_URL/config_file/php70.ini -O $PREFIX/php-templete.ini
wget $DOWNLOAD_URL/config_file/php-node.ini -O $PREFIX/etc/php-node.ini
fi
PREFIX="/vhs/kangle/ext/php71"
if [ -d "$PREFIX" ];then
wget $DOWNLOAD_URL/config_file/php71.ini -O $PREFIX/php-templete.ini
wget $DOWNLOAD_URL/config_file/php-node.ini -O $PREFIX/etc/php-node.ini
fi
PREFIX="/vhs/kangle/ext/php72"
if [ -d "$PREFIX" ];then
wget $DOWNLOAD_URL/config_file/php72.ini -O $PREFIX/php-templete.ini
wget $DOWNLOAD_URL/config_file/php-node.ini -O $PREFIX/etc/php-node.ini
fi
/vhs/kangle/bin/kangle -r
echo -e "————————————————————————————————————————————————————
安装完成
————————————————————————————————————————————————————"