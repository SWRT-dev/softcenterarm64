#!/bin/sh
source /jffs/softcenter/scripts/base.sh
alias echo_date='echo 【$(TZ=UTC-8 date -R +%Y年%m月%d日\ %X)】:'
DIR=$(cd $(dirname $0); pwd)

# stop kms first
enable=`dbus get kms_enable`
if [ "$enable" == "1" ];then
	sh /jffs/softcenter/scripts/kms_config.sh stop
fi

# 安装插件
cp -rf /tmp/kms/scripts/* /jffs/softcenter/scripts/
cp -rf /tmp/kms/bin/* /jffs/softcenter/bin/
cp -rf /tmp/kms/webs/* /jffs/softcenter/webs/
cp -rf /tmp/kms/res/* /jffs/softcenter/res/
chmod +x /jffs/softcenter/scripts/kms*
chmod +x /jffs/softcenter/bin/vlmcsd

# 离线安装用
dbus set kms_version="$(cat $DIR/version)"
dbus set softcenter_module_kms_version="$(cat $DIR/version)"
dbus set softcenter_module_kms_install="1"
dbus set softcenter_module_kms_name="kms"
dbus set softcenter_module_kms_title="系统工具"
dbus set softcenter_module_kms_description="kms"

# re-enable kms
if [ "$enable" == "1" ];then
	sh /jffs/softcenter/scripts/kms_config.sh start
fi

# 完成
echo_date "kms插件安装完毕！"
rm -rf /tmp/kms* >/dev/null 2>&1
exit 0
