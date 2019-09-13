#!/bin/sh
source /jffs/softcenter/scripts/base.sh
/jffs/softcenter/scripts/bxc.sh stop

dbus remove bxc_bcode
dbus remove bxc_option
dbus remove bxc_status
dbus remove bxc_wan_mac
dbus remove bxc_local_version
dbus remove bxc_node_info
dbus remove bxc_user_mail
dbus remove softcenter_module_bxc_install
dbus remove softcenter_module_bxc_version
dbus remove softcenter_module_bxc_title
dbus remove softcenter_module_bxc_description
dbus remove softcenter_module_bxc_home_url
dbus remove softcenter_module_bxc_name

rm /jffs/softcenter/bin/bxc-*
rm /jffs/softcenter/res/icon-bxc.png
rm /jffs/softcenter/res/bxc_run.htm
rm /jffs/softcenter/scripts/bxc*
rm /jffs/softcenter/webs/Module_BxC.asp
rm /jffs/softcenter/init.d/*bxc.sh
rm -rf /jffs/softcenter/bxc
rm /jffs/softcenter/scripts/uninstall_bxc.sh
rm -fr /tmp/etc/bxc-network
rm -fr /tmp/bxc_log.txt
