#! /bin/sh

source /jffs/softcenter/scripts/base.sh

ddnsto_status=`ps | grep -w ddnsto | grep -cv grep`
ddnsto_pid=`pidof ddnsto`
ddnsto_version=`/jffs/softcenter/bin/ddnsto -v`
ddnsto_route_id=`/jffs/softcenter/bin/ddnsto -w | awk '{print $2}'`
if [ "$ddnsto_status" == "2" ];then
	echo "ddnsto  $ddnsto_version 进程运行正常！路由器ID： $ddnsto_route_id PID：$ddnsto_pid" > /tmp/ddnsto.log
else
	echo "ddnsto  $ddnsto_version 【警告】：进程未运行！路由器ID：$ddnsto_route_id" > /tmp/ddnsto.log
fi
