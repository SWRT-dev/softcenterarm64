#! /bin/sh

sh /jffs/softcenter/koolproxyr/koolproxyr.sh stop
rm -rf /jffs/softcenter/bin/koolproxyr >/dev/null 2>&1
rm -rf /jffs/softcenter/koolproxyr/koolproxyr >/dev/null 2>&1
rm -rf /jffs/softcenter/koolproxyr/kp_config.sh >/dev/null 2>&1
rm -rf /jffs/softcenter/koolproxyr/koolproxyr.sh >/dev/null 2>&1
rm -rf /jffs/softcenter/koolproxyr/nat_load.sh >/dev/null 2>&1
rm -rf /jffs/softcenter/koolproxyr/rule_store >/dev/null 2>&1
rm -rf /jffs/softcenter/koolproxyr/data/1.dat >/dev/null 2>&1
rm -rf /jffs/softcenter/koolproxyr/data/koolproxy.txt >/dev/null 2>&1
rm -rf /jffs/softcenter/koolproxyr/data/user.txt >/dev/null 2>&1
rm -rf /jffs/softcenter/koolproxyr/data/rules >/dev/null 2>&1
rm -rf /jffs/softcenter/koolproxyr/data/koolproxy_ipset.conf >/dev/null 2>&1
rm -rf /jffs/softcenter/koolproxyr/data/gen_ca.sh >/dev/null 2>&1
rm -rf /jffs/softcenter/koolproxyr/data/openssl.cnf >/dev/null 2>&1
rm -rf /jffs/softcenter/koolproxyr/data/serial >/dev/null 2>&1
rm -rf /jffs/softcenter/koolproxyr/data/version >/dev/null 2>&1

rm -rf /jffs/softcenter/res/koolproxyr_check.htm
rm -rf /jffs/softcenter/res/koolproxyr_run.htm
rm -rf /jffs/softcenter/res/koolproxyr_user.htm
