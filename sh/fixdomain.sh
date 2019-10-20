#!/bin/bash
files="/root/s-hell"
source $files/config
fil3="/vhs/kangle/nodewww/webftp"
wget -q $DOWNLOAD_FILE_URL/file/domain.tar.bz2 -O domain.tar.bz2
tar xjf domain.tar.bz2
mv -f domain.ctl.php $fil3/vhost/control/domain.ctl.php
chmod 644 $fil3/vhost/control/domain.ctl.php
rm -rf domain.ctl.php
rm -rf domain.tar.bz2
