#!/bin/sh
source /jffs/softcenter/scripts/base.sh
alias echo_date='echo 【$(TZ=UTC-8 date -R +%Y年%m月%d日\ %X)】:'
MODEL=$(nvram get productid)
module=phddns
DIR=$(cd $(dirname $0); pwd)
if [ "$MODEL" == "GT-AC5300" ] || [ "$MODEL" == "GT-AX11000" ] || [ "$MODEL" == "GT-AC2900" ] || [ "$(nvram get merlinr_rog)" == "1" ];then
	ROG=1
elif [ "$MODEL" == "TUF-AX3000" ] || [ "$(nvram get merlinr_tuf)" == "1" ] ;then
	TUF=1
fi

firmware_version=`nvram get extendno|cut -d "_" -f2|cut -d "-" -f1|cut -c2-6`
#api1.5
firmware_check=5.1.2

firmware_comp=`/jffs/softcenter/bin/versioncmp $firmware_version $firmware_check`
if [ "$firmware_comp" == "1" ];then
	echo_date 1.5代api最低固件版本为5.1.2,固件版本过低，无法安装
	exit 1
fi

# stop phddns first
killall -9 phddns_daemon.sh > /dev/null 2>&1
killall -9 oraysl > /dev/null 2>&1
killall -9 oraynewph > /dev/null 2>&1

rm -rf /jffs/softcenter/init.d/*Phddns.sh > /dev/null 2>&1

cp -rf /tmp/phddns/bin/* /jffs/softcenter/bin/
cp -rf /tmp/phddns/oray_op/ /jffs/softcenter/bin/
cp -rf /tmp/phddns/res/* /jffs/softcenter/res/
cp -rf /tmp/phddns/scripts/* /jffs/softcenter/scripts/
cp -rf /tmp/phddns/webs/*  /jffs/softcenter/webs/
cp -rf /tmp/phddns/uninstall.sh /jffs/softcenter/scripts/uninstall_phddns.sh
if [ "$ROG" == "1" ];then
	continue
elif [ "$TUF" == "1" ];then
	sed -i 's/3e030d/3e2902/g;s/91071f/92650F/g;s/680516/D0982C/g;s/cf0a2c/c58813/g;s/700618/74500b/g;s/530412/92650F/g' /jffs/softcenter/webs/Module_phddns.asp >/dev/null 2>&1
else
	sed -i '/rogcss/d' /jffs/softcenter/webs/Module_phddns.asp >/dev/null 2>&1
fi
if [ -f /jffs/softcenter/init.d/S60Phddns.sh ]; then
	rm -rf /jffs/softcenter/init.d/S60Phddns.sh
fi

if [ -L /jffs/softcenter/init.d/S60Phddns.sh ]; then
	rm -rf /jffs/softcenter/init.d/S60Phddns.sh
fi
cp -rf /tmp/phddns/init.d/* /jffs/softcenter/init.d/
#chmod 755 /jffs/softcenter/init.d/*
chmod 755 /jffs/softcenter/scripts/phddns_*.sh
chmod 755 /jffs/softcenter/bin/*
chmod 755 /jffs/softcenter/bin/oray_op/*

# phddns config directory
mkdir /jffs/softcenter/etc > /dev/null 2>&1

# 离线安装用
dbus set phddns_version="$(cat $DIR/version)"
dbus set softcenter_module_phddns_version="$(cat $DIR/version)"
dbus set softcenter_module_phddns_description="花生壳内网版3.0"
dbus set softcenter_module_phddns_install="1"
dbus set softcenter_module_phddns_name="phddns"
dbus set softcenter_module_phddns_title="花生壳内网版"

# complete
echo_date "花生壳内网版3.0 插件安装完毕！"
rm -rf /tmp/qiandao* >/dev/null 2>&1
exit 0
