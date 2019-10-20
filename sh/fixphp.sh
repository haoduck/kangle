#!/bin/bash
files="/root/s-hell"
source $files/config
PREFIX="/vhs/kangle/nodewww/webftp"
wget -q $DOWNLOAD_FILE_URL/file/ep_patch.tar.bz2 -O ep_patch.tar.bz2
tar xjf ep_patch.tar.bz2
mv -f ./ep_patch/php.php $PREFIX/modules/php/php.php
mv -f ./ep_patch/cron.api.php $PREFIX/framework/api/cron.api.php
mv -f ./ep_patch/runtime.php $PREFIX/framework/runtime.php
chmod 644 $PREFIX/modules/php/php.php
chmod 644 $PREFIX/framework/api/cron.api.php
chmod 644 $PREFIX/framework/runtime.php
rm -rf ep_patch
rm -f ep_patch.tar.bz2
