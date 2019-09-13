#! /bin/sh
eval `dbus export koolproxyr`
source /jffs/softcenter/scripts/base.sh

case $ACTION in
start)
	sh /jffs/softcenter/koolproxyr/kp_config.sh start
	;;
*)
	if [ "$koolproxyr_enable" == "1" ];then
		sh /jffs/softcenter/koolproxyr/kp_config.sh restart  > /tmp/koolproxyr_run.log
	else
		sh /jffs/softcenter/koolproxyr/kp_config.sh stop  > /tmp/koolproxyr_run.log
	fi
	echo XU6J03M6 >> /tmp/koolproxyr_run.log
	sleep 1
	rm -rf /tmp/koolproxyr_run.log
	;;
esac
