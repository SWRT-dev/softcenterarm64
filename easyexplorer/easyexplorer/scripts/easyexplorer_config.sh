#!/bin/sh
eval `dbus export easyexplorer`
source /jffs/softcenter/scripts/base.sh
alias echo_date='echo $(date +%Y年%m月%d日\ %X):'

BIN=/jffs/softcenter/bin/easy-explorer
PID_FILE=/var/run/easy-explorer.pid

start_ee(){
	start-stop-daemon -S -q	-b -m -p $PID_FILE -x $BIN -- -c /tmp -u $easyexplorer_token -share $easyexplorer_dir
	[ ! -L "/jffs/softcenter/init.d/S99easyexplorer.sh" ] && ln -sf /jffs/softcenter/scripts/easyexplorer_config.sh /jffs/softcenter/init.d/S99easyexplorer.sh
	[ ! -L "/jffs/softcenter/init.d/N99easyexplorer.sh" ] && ln -sf /jffs/softcenter/scripts/easyexplorer_config.sh /jffs/softcenter/init.d/N99easyexplorer.sh
}

kill_ee(){
	killall	easy-explorer > /dev/null 2>&1
}

load_iptables(){
	iptables -S | grep "2300" | sed 's/-A/iptables -D/g' > clean.sh && chmod 777 clean.sh && ./clean.sh && rm clean.sh > /dev/null 2>&1
	iptables -t	filter -I INPUT -p tcp --dport 2300 -j ACCEPT > /dev/null 2>&1
}

del_iptables(){
	iptables -S | grep "2300" | sed 's/-A/iptables -D/g' > clean.sh && chmod 777 clean.sh && ./clean.sh && rm clean.sh > /dev/null 2>&1
}

#=========================================================
case $1 in
start)
	if [ "$easyexplorer_enable" == "1" ];then
		logger "[软件中心]: 启动easyexplorer插件！"
		kill_ee
		start_ee
		load_iptables
	else
		logger "[软件中心]: easyexplorer插件未开启，不启动！"
	fi
	;;
start_nat)
	if [ -n "$(pidof easy-explorer)" ]; then
		load_iptables
	fi
	;;
*)
	if [ "$easyexplorer_enable" == "1" ];then
		kill_ee
		start_ee
		load_iptables
	else
		kill_ee
		del_iptables
	fi
	;;
esac
