#!/bin/sh
source /jffs/softcenter/scripts/base.sh
alias echo_date='echo 【$(TZ=UTC-8 date -R +%Y年%m月%d日\ %X)】:'
DIR=$(cd $(dirname $0); pwd)
MODEL=$(nvram get productid)
if [ "$MODEL" == "GT-AC5300" ] || [ "$MODEL" == "GT-AX11000" ] || [ "$MODEL" == "GT-AC2900" ] || [ "$(nvram get merlinr_rog)" == "1" ];then
	ROG=1
elif [ "$MODEL" == "TUF-AX3000" ] || [ "$(nvram get merlinr_tuf)" == "1" ] ;then
	TUF=1
fi

# stop easyexplorer first
enable=`dbus get easyexplorer_enable`
if [ "$enable" == "1" ];then
	killall	easy-explorer > /dev/null 2>&1
fi

rm -rf /jffs/softcenter/init.d/*easyexplorer.sh
cp -rf /tmp/easyexplorer/bin/* /jffs/softcenter/bin/
cp -rf /tmp/easyexplorer/scripts/* /jffs/softcenter/scripts/
cp -rf /tmp/easyexplorer/webs/* /jffs/softcenter/webs/
cp -rf /tmp/easyexplorer/res/* /jffs/softcenter/res/
cp -rf /tmp/easyexplorer/uninstall.sh /jffs/softcenter/scripts/uninstall_easyexplorer.sh
if [ "$ROG" == "1" ];then
	continue
elif [ "$TUF" == "1" ];then
	sed -i 's/3e030d/3e2902/g;s/91071f/92650F/g;s/680516/D0982C/g;s/cf0a2c/c58813/g;s/700618/74500b/g;s/530412/92650F/g' /jffs/softcenter/webs/Module_easyexplorer.asp >/dev/null 2>&1
else
	sed -i '/rogcss/d' /jffs/softcenter/webs/Module_easyexplorer.asp >/dev/null 2>&1
fi
chmod +x /jffs/softcenter/bin/easy-explorer
chmod +x /jffs/softcenter/scripts/*
[ ! -L "/jffs/softcenter/init.d/S99easyexplorer.sh" ] && ln -sf /jffs/softcenter/scripts/easyexplorer_config.sh /jffs/softcenter/init.d/S99easyexplorer.sh
[ ! -L "/jffs/softcenter/init.d/N99easyexplorer.sh" ] && ln -sf /jffs/softcenter/scripts/easyexplorer_config.sh /jffs/softcenter/init.d/N99easyexplorer.sh

# 离线安装用
dbus set easyexplorer_version="$(cat $DIR/version)"
dbus set softcenter_module_easyexplorer_version="$(cat $DIR/version)"
dbus set softcenter_module_easyexplorer_description="易有云 （EasyExplorer） 跨平台文件同步，支持双向同步！"
dbus set softcenter_module_easyexplorer_install="1"
dbus set softcenter_module_easyexplorer_name="easyexplorer"
dbus set softcenter_module_easyexplorer_title="易有云"

# re-enable easyexplorer
if [ "$enable" == "1" ];then
	sh /jffs/softcenter/scripts/easyexplorer_config.sh start
fi

# 完成
echo_date "易有云插件安装完毕！"
rm -rf /tmp/easyexplorer* >/dev/null 2>&1
exit 0

