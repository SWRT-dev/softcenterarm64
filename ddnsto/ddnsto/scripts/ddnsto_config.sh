#!/bin/sh

source /jffs/softcenter/scripts/base.sh
eval `dbus export ddnsto`

case $1 in
start)
    if [ "$ddnsto_enable" == "1" ];then
        /jffs/softcenter/bin/ddnsto -u $ddnsto_token -d
    fi
    ;;
restart)
    if [ "$ddnsto_enable" == "1" ];then
        killall ddnsto
        /jffs/softcenter/bin/ddnsto -u $ddnsto_token -d
    else
        killall ddnsto
    fi
    ;;
esac
