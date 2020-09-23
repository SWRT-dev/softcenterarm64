#!/bin/sh
eval `dbus export phddns_`
source /jffs/softcenter/scripts/base.sh

cd /tmp
killall -9 phddns_daemon.sh > /dev/null 2>&1
killall -9 oraysl > /dev/null 2>&1
killall -9 oraynewph > /dev/null 2>&1

rm -rf /jffs/softcenter/bin/oraynewph
rm -rf /jffs/softcenter/bin/oraysl
rm -rf /jffs/softcenter/bin/phddns_daemon.sh
rm -rf /jffs/softcenter/bin/oray_op/
#rm -rf /jffs/softcenter/init.d/*Phddns.sh
rm -rf /jffs/softcenter/scripts/phddns_*.sh
rm -rf /jffs/softcenter/scripts/uninstall_phddns.sh
rm -rf /jffs/softcenter/res/icon-phddns.png
rm -rf /jffs/softcenter/webs/Module_phddns.asp
rm -rf /tmp/oray*

exit 0
