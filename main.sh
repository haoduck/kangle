#!/bin/bash
files="/root/s-hell"
tmpfile="/root/hl-tmp" 
source $files/config

function Installall(){
	cd $tmpfile
	rm -rf $files/log/install.log
	wget -q $DOWNLOAD_URL/lg/install_ver.h -O $files/iver
	wget -q $DOWNLOAD_URL/pre.sh -O pre.sh;sh pre.sh
}
function Installcdn(){
	cd $tmpfile
	rm -rf $files/log/install.log
	wget -q $DOWNLOAD_URL/lg/install_ver.h -O $files/iver
	wget -q $DOWNLOAD_URL/pre.sh -O pre.sh;sh pre.sh no
}
function Check(){
	cd $tmpfile
	wget -q $DOWNLOAD_URL/lg/install_ver.h -O $files/iver
	wget -q $DOWNLOAD_URL/check.sh -O check.sh;sh check.sh
}
function Resql(){
	cd $tmpfile
	rm -rf $files/log/iset.log
	wget -q $DOWNLOAD_URL/lg/install_ver.h -O $files/iver
	wget -q $DOWNLOAD_URL/sh/iset.sh -O iset.sh;sh iset.sh | tee $files/log/iset.log
}
function Resql2(){
	cd $tmpfile
	rm -rf $files/log/reset.log
	wget -q $DOWNLOAD_URL/lg/install_ver.h -O $files/iver
	wget -q $DOWNLOAD_URL/sh/reset.sh -O reset.sh;sh reset.sh | tee $files/log/reset.log
}
function Upyum(){
	isC7=`cat /etc/redhat-release |grep ' 7.'`
	if [ "${isC7}" == "" ];then
		wget -q $DOWNLOAD_FILE_URL/repo/Centos-6.repo -O /etc/yum.repos.d/CentOS-Base.repo
		rpm -ivh $DOWNLOAD_FILE_URL/repo/epel-release-latest-6.noarch.rpm --nodeps --force
		wget -q $DOWNLOAD_FILE_URL/repo/epel-6.repo -O /etc/yum.repos.d/epel.repo
	else
		wget -q $DOWNLOAD_FILE_URL/repo/Centos-7.repo -O /etc/yum.repos.d/CentOS-Base.repo
		rpm -ivh $DOWNLOAD_FILE_URL/repo/epel-release-latest-7.noarch.rpm --nodeps --force
		wget -q $DOWNLOAD_FILE_URL/repo/epel-7.repo -O /etc/yum.repos.d/epel.repo
	fi
	yum clean all
}
function Uninstall(){
	cd $tmpfile
	wget -q $DOWNLOAD_URL/lg/install_ver.h -O $files/iver
	wget -q $DOWNLOAD_URL/uninstall.sh -O uninstall.sh;sh uninstall.sh
}
function Rephp(){
	cd $tmpfile
	wget -q $DOWNLOAD_URL/sh/rephp.sh -O rephp.sh;sh rephp.sh
}
function SetDNS(){
	echo -e "———————————————————————————
	\033[1mＫＡＮＧＬＥＳＯＦＴ\033[0m
	\033[32m修复系统DNS\033[0m
	1. 114DNS（国内服务器）
	2. 谷歌DNS（国外服务器）"
	read -p "请输入序号并回车:" YORN
	if [ "$YORN" = "2" ]; then
		echo -e "options timeout:1 attempts:1 rotate\nnameserver 8.8.8.8\nnameserver 8.8.4.4" >/etc/resolv.conf;
		echo "已经成功更改为谷歌DNS"
	else
		echo -e "options timeout:1 attempts:1 rotate\nnameserver 114.114.114.114\nnameserver 114.114.115.115" >/etc/resolv.conf;
		echo "已经成功更改为114DNS"
	fi
}
function Ntpdate(){
	\cp -a -r /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
	service ntpd stop
	echo 'Synchronizing system time...'
	ntpdate 0.asia.pool.ntp.org
	echo "同步服务器时间成功"
}

function install_upm(){
	cd $tmpfile
	rm -rf $files/log/upm.log
	wget -q $DOWNLOAD_URL/lg/install_ver.h -O $files/iver
	wget -q $DOWNLOAD_URL/sh/upm.sh -O pm.sh;sh pm.sh | tee $files/log/pm.log
}
function install_fxp(){
	cd $tmpfile
	rm -rf $files/log/fxp.log
	wget -q $DOWNLOAD_URL/sh/fixphp.sh -O fixphp.sh;sh fixphp.sh | tee $files/log/fxp.log
}
function install_fxd(){
	cd $tmpfile
	rm -rf $files/log/fxd.log
	wget -q $DOWNLOAD_URL/sh/fixdomain.sh -O fixdomain.sh;sh fixdomain.sh | tee $files/log/fxd.log
}
function install_php(){
	cd $tmpfile
	rm -rf $files/log/php*.log
	wget -q $DOWNLOAD_URL/lg/install_ver.h -O $files/iver
	wget -q $DOWNLOAD_URL/sh/php53.sh -O php53.sh;sh php53.sh | tee $files/log/php53.log
	wget -q $DOWNLOAD_URL/sh/php54.sh -O php54.sh;sh php54.sh | tee $files/log/php54.log
	wget -q $DOWNLOAD_URL/sh/php55.sh -O php55.sh;sh php55.sh | tee $files/log/php55.log
	wget -q $DOWNLOAD_URL/sh/php56.sh -O php56.sh;sh php56.sh | tee $files/log/php56.log
	wget -q $DOWNLOAD_URL/sh/php7.sh -O php7.sh;sh php7.sh | tee $files/log/php7.log
	wget -q $DOWNLOAD_URL/sh/php71.sh -O php71.sh;sh php71.sh | tee $files/log/php71.log
	wget -q $DOWNLOAD_URL/sh/php72.sh -O php72.sh;sh php72.sh | tee $files/log/php72.log
	wget -q $DOWNLOAD_URL/sh/php73.sh -O php73.sh;sh php73.sh | tee $files/log/php73.log
}
function install_php_force(){
	cd $tmpfile
	rm -rf $files/log/php*.log
	wget -q $DOWNLOAD_URL/lg/install_ver.h -O $files/iver
	wget -q $DOWNLOAD_URL/sh/php53.sh -O php53.sh;sh php53.sh force | tee $files/log/php53.log
	wget -q $DOWNLOAD_URL/sh/php54.sh -O php54.sh;sh php54.sh force | tee $files/log/php54.log
	wget -q $DOWNLOAD_URL/sh/php55.sh -O php55.sh;sh php55.sh force | tee $files/log/php55.log
	wget -q $DOWNLOAD_URL/sh/php56.sh -O php56.sh;sh php56.sh force | tee $files/log/php56.log
	wget -q $DOWNLOAD_URL/sh/php7.sh -O php7.sh;sh php7.sh force | tee $files/log/php7.log
	wget -q $DOWNLOAD_URL/sh/php71.sh -O php71.sh;sh php71.sh force | tee $files/log/php71.log
	wget -q $DOWNLOAD_URL/sh/php72.sh -O php72.sh;sh php72.sh force | tee $files/log/php72.log
	wget -q $DOWNLOAD_URL/sh/php73.sh -O php73.sh;sh php73.sh force | tee $files/log/php73.log
}
function install_phpc(){
	cd $tmpfile
	rm -rf $files/log/php*.log
	wget -q $DOWNLOAD_URL/lg/install_ver.h -O $files/iver
	wget -q $DOWNLOAD_URL/sh/php.sh -O php.sh
	sh php.sh php53| tee $files/log/php.log
	sh php.sh php54| tee $files/log/php.log
	sh php.sh php55| tee $files/log/php.log
	sh php.sh php56| tee $files/log/php.log
	sh php.sh php70| tee $files/log/php.log
	sh php.sh php71| tee $files/log/php.log
	sh php.sh php72| tee $files/log/php.log
	sh php.sh php73| tee $files/log/php.log
}
function install_phpc_force(){
	cd $tmpfile
	rm -rf $files/log/php*.log
	wget -q $DOWNLOAD_URL/lg/install_ver.h -O $files/iver
	wget -q $DOWNLOAD_URL/sh/php.sh -O php.sh
	sh php.sh php53 force| tee $files/log/php.log
	sh php.sh php54 force| tee $files/log/php.log
	sh php.sh php55 force| tee $files/log/php.log
	sh php.sh php56 force| tee $files/log/php.log
	sh php.sh php70 force| tee $files/log/php.log
	sh php.sh php71 force| tee $files/log/php.log
	sh php.sh php72 force| tee $files/log/php.log
	sh php.sh php73 force| tee $files/log/php.log
}
function install_php52(){
	cd $tmpfile
	rm -rf $files/log/php52.log
	wget -q $DOWNLOAD_URL/lg/install_ver.h -O $files/iver
	wget -q $DOWNLOAD_URL/sh/php52.sh -O php52.sh;sh php52.sh | tee $files/log/php52.log
}
function install_php53(){
	cd $tmpfile
	rm -rf $files/log/php53.log
	wget -q $DOWNLOAD_URL/lg/install_ver.h -O $files/iver
	wget -q $DOWNLOAD_URL/sh/php53.sh -O php53.sh;sh php53.sh | tee $files/log/php53.log
}
function install_php54(){
	cd $tmpfile
	rm -rf $files/log/php54.log
	wget -q $DOWNLOAD_URL/lg/install_ver.h -O $files/iver
	wget -q $DOWNLOAD_URL/sh/php54.sh -O php54.sh;sh php54.sh | tee $files/log/php54.log
}
function install_php55(){
	cd $tmpfile
	rm -rf $files/log/php52.log
	wget -q $DOWNLOAD_URL/lg/install_ver.h -O $files/iver
	wget -q $DOWNLOAD_URL/sh/php55.sh -O php55.sh;sh php55.sh | tee $files/log/php55.log
}
function install_php56(){
	cd $tmpfile
	rm -rf $files/log/php56.log
	wget -q $DOWNLOAD_URL/lg/install_ver.h -O $files/iver
	wget -q $DOWNLOAD_URL/sh/php56.sh -O php56.sh;sh php56.sh | tee $files/log/php56.log
}
function install_php7(){
	cd $tmpfile
	rm -rf $files/log/php7.log
	wget -q $DOWNLOAD_URL/lg/install_ver.h -O $files/iver
	wget -q $DOWNLOAD_URL/sh/php7.sh -O php7.sh;sh php7.sh | tee $files/log/php7.log
}
function install_php71(){
	cd $tmpfile
	rm -rf $files/log/php71.log
	wget -q $DOWNLOAD_URL/lg/install_ver.h -O $files/iver
	wget -q $DOWNLOAD_URL/sh/php71.sh -O php71.sh;sh php71.sh | tee $files/log/php71.log
}
function install_php72(){
	cd $tmpfile
	rm -rf $files/log/php72.log
	wget -q $DOWNLOAD_URL/lg/install_ver.h -O $files/iver
	wget -q $DOWNLOAD_URL/sh/php72.sh -O php72.sh;sh php72.sh | tee $files/log/php72.log
}
function phpini(){
	cd $tmpfile
	wget -q $DOWNLOAD_URL/sh/phpini.sh -O phpini.sh;sh phpini.sh
}
function install_mysql(){
	#设置MySQL密码
	mysql_root_password=""
	read -p "请输入您需要设置的MySQL密码:" mysql_root_password
	if [ "$mysql_root_password" = "" ]; then
	mysql_root_password="mysql"
	fi
	echo '[OK] Your MySQL password is:';
	echo $mysql_root_password;

	cd $tmpfile
	rm -rf $files/log/sql.log
	wget -q $DOWNLOAD_URL/sh/sql.sh -O sql.sh;sh sql.sh $mysql_root_password | tee $files/log/sql.log
}
function install_kangle(){
	wget -q $DOWNLOAD_URL/lg/install_ver.h -O $files/iver
	source $files/iver
	cd $tmpfile
	echo -e "———————————————————————————
	\033[1mＫＡＮＧＬＥＳＯＦＴ\033[0m
	\033[32mKangle版本选择(极速安装均为商业版)\033[0m
	1. 极速安装 Kangle 3.5.17 最新版
	2. 极速安装 Kangle 3.5.16 开发版
	3. 编译安装 Kangle 3.5.16 开发版
	4. 极速安装 Kangle 3.4.8 经典版
	5. 编译安装 Kangle 3.4.8 经典版"
	read -p "请输入序号并回车:" YORN
	if [ "$YORN" = "2" ]; then
		kangle_var="$KANGLE_ENT_VERSION";
		rm -rf $files/log/kangle.log
		wget -q $DOWNLOAD_URL/lg/install_ver.h -O $files/iver
		wget -q $DOWNLOAD_URL/sh/kangle.sh -O kangle.sh;sh kangle.sh $kangle_var 1 | tee $files/log/kangle.log
	elif [ "$YORN" = "3" ]; then
		kangle_var="$KANGLE_VERSION";
		rm -rf $files/log/kangle.log
		wget -q $DOWNLOAD_URL/lg/install_ver.h -O $files/iver
		wget -q $DOWNLOAD_URL/sh/kangle.sh -O kangle.sh;sh kangle.sh $kangle_var 0 | tee $files/log/kangle.log
	elif [ "$YORN" = "4" ]; then
		kangle_var="$KANGLE_OLD_VERSION";
		rm -rf $files/log/kangle.log
		wget -q $DOWNLOAD_URL/lg/install_ver.h -O $files/iver
		wget -q $DOWNLOAD_URL/sh/kangle.sh -O kangle.sh;sh kangle.sh $kangle_var 1 | tee $files/log/kangle.log
	elif [ "$YORN" = "5" ]; then
		kangle_var="$KANGLE_OLD_VERSION";
		rm -rf $files/log/kangle.log
		wget -q $DOWNLOAD_URL/lg/install_ver.h -O $files/iver
		wget -q $DOWNLOAD_URL/sh/kangle.sh -O kangle.sh;sh kangle.sh $kangle_var 0 | tee $files/log/kangle.log
	else
		kangle_var="$KANGLE_NEW_VERSION";
		rm -rf $files/log/kangle.log
		wget -q $DOWNLOAD_URL/lg/install_ver.h -O $files/iver
		wget -q $DOWNLOAD_URL/sh/kangle.sh -O kangle.sh;sh kangle.sh $kangle_var 1 | tee $files/log/kangle.log
	fi
}
function install_easypanel(){
	cd $tmpfile
	rm -rf $files/log/ep.log
	wget -q $DOWNLOAD_URL/lg/install_ver.h -O $files/iver
	wget -q $DOWNLOAD_URL/sh/ep.sh -O ep.sh;sh ep.sh force | tee $files/log/ep.log
}
function setvhms(){
	wget -q $DOWNLOAD_URL/sh/vhms.sh -O vhms.sh;sh vhms.sh
}
function Update(){
	cd $tmpfile
	links="https://raw.githubusercontent.com/haoduck/kangle/master"
	wget -q $links/config -O $files/config
	wget -q $links/main.sh -O main.sh;
	cp -f main.sh /usr/bin/kanglesh
	echo "更新成功"
	sh main.sh
}
function flowcron(){
	sed -i 's/tpl_php52/php53/g' /etc/cron.d/ep_sync_flow
	/etc/init.d/crond restart
	echo -e "修改保存成功
"
}
function Easypanel_view(){
	cd $tmpfile
	wget -q $DOWNLOAD_URL/sh/view.sh -O view.sh;sh view.sh
}
function Resetpwd(){
	clear
	read -p "请输入Kangle管理员-新用户名：" ep_admin
	echo -e "\033[44;37m 你输入Kangle管理员-新用户名是：$ep_admin \033[0m"
	read -p "请输入Kangle管理员-新密码：" ep_passwd
	echo -e "\033[44;37m 你输入Kangle管理员-新密码是：$ep_passwd \033[0m"
	# passwdmd5=` echo -n '$ep_passwd'|md5sum|cut -d ' ' -f1 `
	nl /vhs/kangle/etc/config.xml | sed -i "s/admin user='.*' password='.*' a/admin user='$ep_admin' password='$ep_passwd' a/g" /vhs/kangle/etc/config.xml
	service kangle restart
	echo "Kangle管理员账户&密码已修改成功"
}
function Clean(){
	echo "正在执行清理垃圾任务，执行时间由文件数量决定，请耐心等待。。。"
	rm -rf /vhs/kangle/tmp/*
	rm -rf /tmp
	mkdir /tmp
	chmod -R 777 /tmp
	/vhs/kangle/bin/kangle --reboot

	echo "清理垃圾文件释放空间执行完毕！"
}

function InstallPHP(){
clear
echo -e "————————————————————————————————————————————————————
	\033[1mＫＡＮＧＬＥＳＯＦＴ\033[0m
	\033[32mKangle一键脚本-单独安装PHP\033[0m
	说明：以下内容已经包含在'安装全部'里面
————————————————————————————————————————————————————
1. ◎ 自动安装/更新 PHP5.3-7.3（极速安装）
2. ◎ 自动安装/更新 PHP5.3-7.3（编译安装）
3. ◎ 重新安装 PHP5.3-7.3（极速安装）
4. ◎ 重新安装 PHP5.3-7.3（编译安装）
5. ◎ 编译安装 PHP5.2
0. ◎ 返回上一级菜单"
read -p "请输入序号并回车：" num
case "$num" in
[1] ) (install_phpc);;
[2] ) (install_php);;
[3] ) (install_phpc_force);;
[4] ) (install_php_force);;
[5] ) (install_php52);;
[0] ) (Install);;
*) (InstallPHP);;
esac
}

function Tools(){
clear
echo -e "————————————————————————————————————————————————————
	\033[1mＫＡＮＧＬＥＳＯＦＴ\033[0m
	\033[32mKangle一键脚本-Linux工具箱\033[0m
————————————————————————————————————————————————————
1. ◎ 重置系统Yum源
2. ◎ 修改系统DNS设置
3. ◎ 同步服务器时间
4. ◎ 清理垃圾文件释放空间
0. ◎ 返回上一级菜单"
read -p "请输入序号并回车：" num
case "$num" in
[1] ) (Upyum);;
[2] ) (SetDNS);;
[3] ) (Ntpdate);;
[4] ) (Clean);;
[0] ) (Init);;
*) (Install);;
esac
}

function Install(){
clear
echo -e "————————————————————————————————————————————————————
	\033[1mＫＡＮＧＬＥＳＯＦＴ\033[0m
	\033[32mKangle一键脚本-单独安装\033[0m
	说明：以下内容已经包含在'安装全部'里面
————————————————————————————————————————————————————
1. ◎ 自动安装/更新 Kangle
2. ◎ 自动安装/更新 Easypanel
3. ◎ 选择要安装的PHP版本
4. ◎ 重新安装 MySQL5.6
5. ◎ 安装Easypanel PHP修复补丁
6. ◎ 安装Easypanel 域名泛绑定补丁
7. ◎ 设置VHMS计划任务
8. ◎ 重置全部PHP版本php.ini文件
9. ◎ 修复EP流量统计计划任务
0. ◎ 返回上一级菜单"
read -p "请输入序号并回车：" num
case "$num" in
[1] ) (install_kangle);;
[2] ) (install_easypanel);;
[3] ) (InstallPHP);;
[4] ) (install_mysql);;
[5] ) (install_fxp);;
[6] ) (install_fxd);;
[7] ) (setvhms);;
[8] ) (phpini);;
[9] ) (flowcron);;
[0] ) (Init);;
*) (Install);;
esac
}

function Init(){
clear
echo -e "————————————————————————————————————————————————————
	\033[1mＫＡＮＧＬＥＳＯＦＴ\033[0m
	\033[32mKangle一键脚本-主菜单\033[0m
	说明：kanglesh命令可随时打开当前菜单
————————————————————————————————————————————————————
1. ◎ 安装全部 Kangle/Easypanel/PHP/Mysql
2. ◎ 安装全部 Kangle/Easypanel/PHP (CDN专用)
3. ◎ 单独安装组件
4. ◎ 更换 Easypanel 模板
5. ◎ 重置MySQL数据库密码
6. ◎ 重置Kangle后台登录密码
7. ◎ 自定义卸载PHP版本
8. ◎ 完全卸载Kangle
9. ◎ Linux工具箱
a. ◎ 更新当前脚本
0. ◎ 退出安装"
read -p "请输入序号并回车：" num
case "$num" in
[1] ) (Installall);;
[2] ) (Installcdn);;
[3] ) (Install);;
[4] ) (Easypanel_view);;
[5] ) (Resql);;
[6] ) (Resetpwd);;
[7] ) (Rephp);;
[8] ) (Uninstall);;
[9] ) (Tools);;
[a] ) (Update);;
[0] ) (exit);;
*) (Init);;
esac
}

Init
