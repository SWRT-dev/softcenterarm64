#!/bin/sh

sh /jffs/softcenter/scripts/tailscale_config.sh stop


rm -rf /jffs/softcenter/scripts/uninstall_tailscale.sh
rm -rf /jffs/softcenter/res/icon-tailscale.png
rm -rf /jffs/softcenter/scripts/tailscale*
rm -rf /jffs/softcenter/webs/Module_tailscale.asp
rm -rf /jffs/softcenter/etc/tailscale
find /jffs/softcenter/init.d/ -name "*tailscale.sh*"|xargs rm -rf

# remove icon from softerware center

dbus remove tailscale_version
dbus remove softcenter_module_tailscale_version
dbus remove softcenter_module_tailscale_description
dbus remove softcenter_module_tailscale_install
dbus remove softcenter_module_tailscale_name
dbus remove softcenter_module_tailscale_title
