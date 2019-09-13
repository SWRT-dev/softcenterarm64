#! /bin/sh
source /jffs/softcenter/scripts/base.sh

easyexplorer_status=`pidof easy-explorer`
easyexplorer_pid=`pidof easy-explorer`
easyexplorer_info=`/jffs/softcenter/bin/easy-explorer -vv`
easyexplorer_ver=`echo ${easyexplorer_info} | awk '{print $1}'`
easyexplorer_rid=`echo ${easyexplorer_info} | awk '{print $2}'`
if [ -n "$easyexplorer_status" ];then
	echo "进程运行正常！版本：${easyexplorer_ver} 路由器ID：${easyexplorer_rid} （PID：$easyexplorer_pid）" > /tmp/easyexplorer.log
else
	echo "【警告】：进程未运行！版本：${easyexplorer_ver} 路由器ID：${easyexplorer_rid}" > /tmp/easyexplorer.log
fi

