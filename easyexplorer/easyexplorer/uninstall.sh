#!/bin/sh
eval `dbus export easyexplorer_`
source /jffs/softcenter/scripts/base.sh

cd /tmp
killall	easy-explorer > /dev/null 2>&1

rm -rf /jffs/softcenter/init.d/*easyexplorer.sh
rm -rf /jffs/softcenter/bin/easyexplorer
rm -rf /jffs/softcenter/res/icon-easyexplorer.png
rm -rf /jffs/softcenter/scripts/easyexplorer*.sh
rm -rf /jffs/softcenter/webs/Module_easyexplorer.asp
rm -rf /jffs/softcenter/scripts/uninstall_easyexplorer.sh
rm -rf /tmp/easyexplorer*
