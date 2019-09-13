#! /bin/sh
# bxc install script for AM380 merlin firmware
# by sean.ley (ley@bonuscloud.io)

eval `dbus export bxc`
source /jffs/softcenter/scripts/base.sh
alias echo_date='echo 【$(TZ=UTC-8 date -R +%Y年%m月%d日\ %X)】:'

# 获取上联口MAC地址
wan_mac=`nvram get wan0_hwaddr`
if [ "$wan_mac"x != ""x ]; then
	echo_date 设备MAC地址为：$wan_mac
else
	echo_date 从NVRAM获取MAC地址失败，建议设备恢复出厂设置后重新安装，退出安装！
	exit 1
fi

# 复制文件
mkdir -p /jffs/softcenter/bxc > /dev/null 2>&1
if [ -d /jffs/softcenter/bxc ];then
	echo_date 设备jffs/softcenter目录检测通过，开始复制文件...
	cd /tmp
	cp -rf /tmp/bxc/scripts/* /jffs/softcenter/scripts/
	chmod a+x /jffs/softcenter/scripts/bxc*
	cp -rf /tmp/bxc/bin/* /jffs/softcenter/bin/
	chmod a+x /jffs/softcenter/bin/bxc*
	cp -rf /tmp/bxc/webs/* /jffs/softcenter/webs/
	cp -rf /tmp/bxc/lib/* /jffs/softcenter/lib/
	cp -rf /tmp/bxc/res/* /jffs/softcenter/res/
	cp -rf /tmp/bxc/bxc/* /jffs/softcenter/bxc/
	cp -rf /tmp/bxc/uninstall.sh /jffs/softcenter/scripts/uninstall_bxc.sh
else
	echo_date 设备/jffs/softcenter目录无法写入，退出安装！
	exit 1
fi



# 如果本地存有邀请码，可以加载使用
if [ -s /jffs/softcenter/bxc/bcode ];then
	bcode=`cat /jffs/softcenter/bxc/bcode`
	if [ -s /jffs/softcenter/bxc/email ];then
		mail=`cat /jffs/softcenter/bxc/email`
		dbus set bxc_user_mail="$mail"
	fi
	dbus set bxc_bcode="$bcode"
	echo_date 设备中已有绑定信息，绑定邀请码为:"$bcode"，用户为:"$mail"
else
	dbus set bxc_bcode=""
	echo_date 设备中未检测到邀请码，运行时需要先绑定设备。
fi


# 离线安装时设置软件中心内储存的版本号和连接
echo_date 设置环境变量...
CUR_VERSION=`cat /jffs/softcenter/bxc/version`
dbus set bxc_local_version="$CUR_VERSION"
echo_date 安装版本信息："$CUR_VERSION"
source /jffs/softcenter/bxc/bxc.config 
dbus set bxc_log_level="$LOG_LEVEL"
dbus set bxc_wan_mac="$wan_mac"
dbus set softcenter_module_bxc_install="4"
dbus set softcenter_module_bxc_version="$CUR_VERSION"
dbus set softcenter_module_bxc_title="BonusCloud-Node"
dbus set softcenter_module_bxc_description="BonusCloud-Node"
dbus set softcenter_module_bxc_home_url=Module_BxC.asp
dbus set softcenter_module_bxc_name="BonusCloud-Node"

# 运行状态初始化
echo_date 安装依赖环境...

echo_date 运行数据初始化...
/jffs/softcenter/scripts/bxc.sh status
/jffs/softcenter/scripts/bxc.sh booton


# delete install tar
rm -rf /tmp/bxc* >/dev/null 2>&1

echo_date 安装完毕，您可以在软件中心打开BonusCloud-Node，绑定设备后运行程序！
exit 0
