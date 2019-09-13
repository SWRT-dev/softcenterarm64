#!/bin/sh
source /jffs/softcenter/scripts/base.sh
alias echo_date='echo 【$(TZ=UTC-8 date -R +%Y年%m月%d日\ %X)】:'
DIR=$(cd $(dirname $0); pwd)

# stop ddnsto first
enable=`dbus get ddnsto_enable`
if [ -n "$enable" ];then
	killall ddnsto >/dev/null 2>&1
fi

# 安装插件
rm -rf /jffs/softcenter/init.d/S70ddnsto.sh
cp -rf /tmp/ddnsto/bin/* /jffs/softcenter/bin/
cp -rf /tmp/ddnsto/scripts/* /jffs/softcenter/scripts/
cp -rf /tmp/ddnsto/webs/* /jffs/softcenter/webs/
cp -rf /tmp/ddnsto/res/* /jffs/softcenter/res/
cp -rf /tmp/ddnsto/uninstall.sh /jffs/softcenter/scripts/uninstall_ddnsto.sh
chmod +x /jffs/softcenter/bin/ddnsto
chmod +x /jffs/softcenter/scripts/ddnsto*
chmod +x /jffs/softcenter/scripts/uninstall_ddnsto.sh
[ ! -L "/jffs/softcenter/init.d/S70ddnsto.sh" ] && ln -sf /jffs/softcenter/scripts/ddnsto_config.sh /jffs/softcenter/init.d/S70ddnsto.sh

# 离线安装用
dbus set ddnsto_version="$(cat $DIR/version)"
dbus set softcenter_module_ddnsto_version="$(cat $DIR/version)"
dbus set ddnsto_title="DDNSTO远程控制"
dbus set ddnsto_client_version=`/jffs/softcenter/bin/ddnsto -v`
dbus set softcenter_module_ddnsto_install="1"
dbus set softcenter_module_ddnsto_name="ddnsto"
dbus set softcenter_module_ddnsto_title="ddnsto远程控制"
dbus set softcenter_module_ddnsto_description="ddnsto内网穿透"

# re-enable ddnsto
if [ "$enable" == "1" ];then
	sh /jffs/softcenter/scripts/ddnsto_config.sh start
fi

echo_date "ddnsto插件安装完毕！"
rm -rf /tmp/ddnsto* >/dev/null 2>&1
exit 0

