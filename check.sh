#!/bin/bash
files="/root/s-hell"
source $files/config
source $files/iver
PREFIX2="/vhs/kangle/ext"
PREFIX="/vhs/kangle/ext/php"
pv2=`"$PREFIX2"/tpl_php52/bin/php -v |grep "$PHP52" -o`
pv3=`"$PREFIX"53/bin/php -v |grep "$PHP53" -o`
pv4=`"$PREFIX"54/bin/php -v |grep "$PHP54" -o`
pv5=`"$PREFIX"55/bin/php -v |grep "$PHP55" -o`
pv6=`"$PREFIX"56/bin/php -v |grep "$PHP56" -o`
pv7=`"$PREFIX"70/bin/php -v |grep "$PHP7" -o`
pv8=`"$PREFIX"71/bin/php -v |grep "$PHP71" -o`
pv9=`"$PREFIX"72/bin/php -v |grep "$PHP72" -o`
pv10=`"$PREFIX"73/bin/php -v |grep "$PHP73" -o`

IP=`curl -s http://members.3322.org/dyndns/getip`;
clear
case $pv2 in
   $PHP52)  P2="PHP-$PHP52已安装";;
   *) P2="PHP-$PHP52未安装/更新.";;
esac
clear
case $pv3 in
   $PHP53) P3="PHP-$PHP53已安装";;
   *) P3="PHP-$PHP53未安装/更新.";;
esac
clear
case $pv4 in
   $PHP54) P4="PHP-$PHP54已安装";;
   *) P4="PHP-$PHP54未安装/更新.";;
esac
clear
case $pv5 in
   $PHP55) P5="PHP-$PHP55已安装";;
   *) P5="PHP-$PHP55未安装/更新.";;
esac
clear
case $pv6 in
   $PHP56) P6="PHP-$PHP56已安装";;
   *) P6="PHP-$PHP56未安装/更新.";;
esac
clear
case $pv7 in
   $PHP7) P7="PHP-$PHP7已安装";;
   *) P7="PHP-$PHP7未安装/更新.";;
esac
clear
case $pv8 in
   $PHP71) P8="PHP-$PHP71已安装";;
   *) P8="PHP-$PHP71未安装/更新.";;
esac
clear
case $pv9 in
   $PHP72) P9="PHP-$PHP72已安装";;
   *) P9="PHP-$PHP72未安装/更新.";;
esac
clear
case $pv10 in
   $PHP73) P10="PHP-$PHP73已安装";;
   *) P10="PHP-$PHP73未安装/更新.";;
esac
clear
echo -e "————————————————————————————————————————————————————
	\033[1mＫＡＮＧＬＥＳＯＦＴ\033[0m
	\033[32;5mKangle一键脚本状态检测\033[0m
————————————————————————————————————————————————————
Kangle一键脚本默认安装PHP53-PHP70
PHP52:\033[32;5m"$P2"\033[0m
PHP53:\033[32;5m"$P3"\033[0m
PHP54:\033[32;5m"$P4"\033[0m
PHP55:\033[32;5m"$P5"\033[0m
PHP56:\033[32;5m"$P6"\033[0m
PHP70:\033[32;5m"$P7"\033[0m
PHP71:\033[32;5m"$P8"\033[0m
PHP72:\033[32;5m"$P9"\033[0m
PHP73:\033[32;5m"$P10"\033[0m
请使用浏览器访问 
http://"$IP":3312/admin
Easypanel 账号: \033[32;5madmin\033[0m 	Mysql 账号: \033[32;5mroot\033[0m
Easypanel 密码: \033[32;5mkangle\033[0m	Mysql 密码: \033[32;5mmysql\033[0m
————————————————————————————————————————————————————"
input_enter=""
read -p "(任意键返回主菜单)" input_enter
if [ "$input_enter"!="" ]; 
then
wget -q $DOWNLOAD_URL/main.sh -O main.sh;sh main.sh
fi