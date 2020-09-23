#!/bin/sh

PhddnsPath=/jffs/softcenter/bin
ORAY_DAEMON="$PhddnsPath/phddns_daemon.sh"

###start peanuthull###
start()
{

killall -9 oraysl
killall -9 oraynewph

$ORAY_DAEMON >/dev/null 2>&1 &
}

##stop peanuthull###
stop()
{

killall phddns_daemon.sh || true
killall -9 oraysl || true
killall -9 oraynewph || true

##clean the statu file##
rm -rf /tmp/oraysl.status
}

reset(){
	
rm -rf /jffs/softcenter/etc/init.status
rm -rf /jffs/softcenter/etc/PhMain.ini
	
}

case $1 in 
	start)
		start
		exit 0
		;;
	stop)
		stop 
		exit 0
		;;
	reset)
		reset
		exit 0
		;;
	*)
		echo "Usage : $0(start|stop|reset)"
		exit 1
		;;

esac
