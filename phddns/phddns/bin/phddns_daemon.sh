#!/bin/sh

PhddnsPath=/jffs/softcenter/bin

ORAYNEWPH_COMMAND="$PhddnsPath/oraynewph -s 0.0.0.0 -c /var/log/phddns/core.log -p /var/log/phddns -l oraynewph -f /jffs/softcenter/etc -t /jffs/softcenter/etc/init.status -i /tmp/oraysl.pid -u /tmp/oraynewph.status -x"
ORAYSL_COMMAND="$PhddnsPath/oraysl -a 127.0.0.1 -p 16062 -s phsle01.oray.net:6061 -l /var/log/phddns -L oraysl -f /jffs/softcenter/etc -S /jffs/softcenter/bin/oray_op -t /jffs/softcenter/etc/init.status -i /tmp/oraysl.pid -u /tmp/oraysl.status"


checkoraysl(){
	if [ -z "$(pidof oraysl)" ]; then
                $ORAYSL_COMMAND >/dev/null 2>&1 &
                echo "oraysl started"
        fi
}
checkoraynewph(){
     	if [ -z "$(pidof oraynewph)" ]; then
                $ORAYNEWPH_COMMAND >/dev/null 2>&1 &
                echo "oraynewph started"
        fi
}
while true
	do 
	checkoraysl
	checkoraynewph
	sleep 1
	done
