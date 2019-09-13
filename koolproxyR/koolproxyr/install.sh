#! /bin/sh
eval `dbus export koolproxyr`

# stop first
[ "$koolproxyr_enable" == "1" ] && sh /jffs/softcenter/koolproxyr/kp_config.sh stop

# remove old files
rm -rf /jffs/softcenter/bin/koolproxyr >/dev/null 2>&1
rm -rf /jffs/softcenter/init.d/*koolproxyr.sh
rm -rf /jffs/softcenter/scripts/koolproxyr*
rm -rf /jffs/softcenter/webs/Module_koolproxyr.asp
rm -rf /jffs/softcenter/koolproxyr/*.sh >/dev/null 2>&1
rm -rf /jffs/softcenter/koolproxyr/koolproxy >/dev/null 2>&1
rm -rf /jffs/softcenter/koolproxyr/data/*.sh >/dev/null 2>&1
rm -rf /jffs/softcenter/koolproxyr/data/koolproxy_ipset.conf >/dev/null 2>&1
rm -rf /jffs/softcenter/koolproxyr/data/openssl.cnf >/dev/null 2>&1
rm -rf /jffs/softcenter/koolproxyr/data/rules/*.dat >/dev/null 2>&1
rm -rf /jffs/softcenter/koolproxyr/data/rules/*.txt >/dev/null 2>&1

# remove old ss event
cd /tmp
dbus list __|grep koolproxyr |cut -d "=" -f1 | sed 's/-A/iptables -t nat -D/g'|sed 's/^/dbus remove /g' > remove.sh && chmod 777 remove.sh && ./remove.sh


# copy new files
cd /tmp
mkdir -p /jffs/softcenter/koolproxyr
mkdir -p /jffs/softcenter/koolproxyr/data
cp -rf /tmp/koolproxyr/scripts/* /jffs/softcenter/scripts/
cp -rf /tmp/koolproxyr/webs/* /jffs/softcenter/webs/
cp -rf /tmp/koolproxyr/res/* /jffs/softcenter/res/
if [ ! -f /jffs/softcenter/koolproxyr/data/rules/user.txt ];then
	cp -rf /tmp/koolproxyr/koolproxyr /jffs/softcenter/
else
	mv /jffs/softcenter/koolproxyr/data/rules/user.txt /tmp/user.txt.tmp
	cp -rf /tmp/koolproxyr/koolproxyr /jffs/softcenter/
	mv /tmp/user.txt.tmp /jffs/softcenter/koolproxyr/data/rules/user.txt
fi
cp -f /tmp/koolproxyr/uninstall.sh /jffs/softcenter/scripts/uninstall_koolproxyr.sh

chmod 755 /jffs/softcenter/koolproxyr/*
chmod 755 /jffs/softcenter/koolproxyr/data/*
chmod 755 /jffs/softcenter/scripts/*
[ ! -e "/jffs/softcenter/bin/koolproxyr" ] && cp -f /jffs/softcenter/koolproxyr/koolproxyr /jffs/softcenter/bin/koolproxyr
[ ! -L "/jffs/softcenter/init.d/S98koolproxyr.sh" ] && ln -sf /jffs/softcenter/koolproxyr/kp_config.sh /jffs/softcenter/init.d/S98koolproxyr.sh
rm -rf /tmp/koolproxyr* >/dev/null 2>&1

[ -z "$koolproxyr_policy" ] && dbus set koolproxyr_policy=1
[ -z "$koolproxyr_acl_default_mode" ] && dbus set koolproxyr_acl_default_mode=1
dbus set softcenter_module_koolproxyr_install=1
dbus set softcenter_module_koolproxyr_version=3.8.4
dbus set koolproxyr_version=3.8.4


[ "$koolproxyr_enable" == "1" ] && sh /jffs/softcenter/koolproxyr/kp_config.sh restart
