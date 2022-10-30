#!/bin/sh

source /jffs/softcenter/scripts/base.sh
eval `dbus export tailscale_`

alias echo_date='echo 【$(TZ=UTC-8 date -R +%Y年%m月%d日\ %X)】:'
PID_FILE=/var/run/tailscaled.pid


tailscale_start(){
	local subnet subnet1 subnet2 subnet3
	if [ "${tailscale_enable}" == "1" ];then
		subnet=`nvram get lan_ipaddr`
		subnet1=`echo $subnet |cut -d. -f1`
		subnet2=`echo $subnet |cut -d. -f2`
		subnet3=`echo $subnet |cut -d. -f3`
		subnet="${subnet1}.${subnet2}.${subnet3}.0/24"
		mkdir -p /jffs/softcenter/etc/tailscale
		ln -sf /jffs/softcenter/etc/tailscale /tmp/var/lib/tailscale
		/jffs/softcenter/bin/tailscaled --cleanup
		start-stop-daemon -S -q -b -m -p ${PID_FILE} -x /jffs/softcenter/bin/tailscaled
		/jffs/softcenter/bin/tailscale up --accept-routes --advertise-routes=${subnet} &
    fi
}

tailscale_stop(){
	/jffs/softcenter/bin/tailscaled --cleanup
	killall tailscale
	killall tailscaled
	rm -rf /tmp/var/lib/tailscale
	dbus set tailscale_online=0
}

tailscale_login(){
	local url
	url=`/jffs/softcenter/bin/tailscale status | grep "Log in at" | cut -d " " -f 4 | base64`
	dbus set tailscale_login_url=${url}
}

tailscale_status(){
	local status
	status=`/jffs/softcenter/bin/tailscale status | grep "Log in at"`
	if [ "$status" == "" ]; then
		dbus set tailscale_online=1
	else 
		dbus set tailscale_online=0
	fi

}


case $1 in
start_nat)
		tailscale_stop
		tailscale_start
        ;;
esac

case $2 in
start)
		tailscale_stop
		tailscale_start
        ;;
stop)
		tailscale_stop
        ;;
get_url)
		tailscale_login
        ;;
get_status)
		tailscale_status
        ;;
restart)
		tailscale_stop
		tailscale_start
        ;;
esac

