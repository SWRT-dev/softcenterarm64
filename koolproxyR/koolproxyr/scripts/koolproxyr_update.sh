#!/bin/sh

wget --no-check-certificate -q -O /tmp/daily https://raw.githubusercontent.com/user1121114685/koolproxyR/master/koolproxyR/koolproxyR/data/rules/easylistchina.txt

wget --no-check-certificate -q -O /tmp/fanboy-annoyance.txt https://raw.githubusercontent.com/user1121114685/koolproxyR/master/koolproxyR/koolproxyR/data/rules/fanboy-annoyance.txt

wget --no-check-certificate -q -O /tmp/kp.dat https://raw.githubusercontent.com/user1121114685/koolproxyR/master/koolproxyR/koolproxyR/data/rules/kp.dat

wget --no-check-certificate -q -O /tmp/yhosts.txt https://raw.githubusercontent.com/user1121114685/koolproxyR/master/koolproxyR/koolproxyR/data/rules/yhosts.txt

wget --no-check-certificate -q -O /tmp/kpr_video_list.txt https://raw.githubusercontent.com/user1121114685/koolproxyR/master/koolproxyR/koolproxyR/data/rules/kpr_video_list.txt

wget --no-check-certificate -q -O /tmp/user.txt https://raw.githubusercontent.com/user1121114685/koolproxyR/master/koolproxyR/koolproxyR/data/rules/user.txt

cat /tmp/fanboy-annoyance.txt /tmp/yhosts.txt > /tmp/koolproxy

cat /tmp/kpr_video_list.txt  /tmp/user.txt > /tmp/user

rm -rf  /tmp/fanboy-annoyance.txt /tmp/yhosts.txt /tmp/kpr_video_list.txt  /tmp/user.txt

echo "
!x  -----------------------------------------------------------------------------------------------------------------
!x  -----[KoolProxy 3.8.4]
!x  -----Thanks: From lvba Rule Group
!x  -----Thanks for help: <yiclear> <adbyby> <adm> <adblock> <adguard>
" > /tmp/koolproxy.txt

echo "
!x  -----------------------------------------------------------------------------------------------------------------
!x  -----[KoolProxy 3.8.4]
!x  -----Thanks: From lvba Group
!x  -----Thanks for help: <yiclear> <adbyby> <adm> <adblock> <adguard>
!x  -----------------------------------------------------------------------------------------------------------------
! ---- baidu union ----
|http://*/*mgkokpa.js
|http://*/*rlptqpn.js
! ---- baidu union ----
! ---- unsafe download ----
|http://*/*_*@*.exe
|http://*/*@*_*.exe
! ---- unsafe download ----
!x  -----------------------------------------------------------------------------------------------------------------" > /tmp/daily.txt
echo "
!x  -----------------------------------------------------------------------------------------------------------------
!x  -----[KoolProxy 3.8.4]
!x  -----Thanks: From lvba Group
!x  -----Thanks for help: <yiclear> <adbyby> <adm> <adblock> <adguard>
!x  -----------------------------------------------------------------------------------------------------------------
!x  -----------------------------------------------------------------------------------------------------------------" > /tmp/user.txt

sort /tmp/koolproxy  >> /tmp/koolproxy.txt
sort /tmp/daily  >> /tmp/daily.txt
sort /tmp/user >> /tmp/user.txt
rm -rf /tmp/koolproxy /tmp/daily /tmp/user

if [ -s "/tmp/koolproxy.txt" ]; then
	if ( ! cmp -s /tmp/koolproxy.txt /jffs/softcenter/koolproxyr/data/rules/koolproxy.txt ); then
		mv -f /tmp/koolproxy.txt /jffs/softcenter/koolproxyr/data/rules/koolproxy.txt
	else
		rm -f /tmp/koolproxy.txt
	fi	
fi

if [ -s "/tmp/daily.txt" ]; then
	if ( ! cmp -s /tmp/daily.txt /jffs/softcenter/koolproxyr/data/rules/daily.txt ); then
		mv -f /tmp/daily.txt /jffs/softcenter/koolproxyr/data/rules/daily.txt 
	else
		rm -f /tmp/daily.txt 
	fi	
fi

if [ -s "/tmp/user.txt" ]; then
	if ( ! cmp -s /tmp/user.txt /jffs/softcenter/koolproxyr/data/rules/user.txt ); then
		mv -f /tmp/user.txt /jffs/softcenter/koolproxyr/data/rules/user.txt 
	else
		rm -f /tmp/user.txt 
	fi	
fi

if [ -s "/tmp/kp.dat" ]; then
	if ( ! cmp -s /tmp/kp.dat /jffs/softcenter/koolproxyr/data/rules/kp.dat ); then
		mv -f /tmp/kp.dat /jffs/softcenter/koolproxyr/data/rules/kp.dat 
	else
		rm -f /tmp/kp.dat 
	fi	
fi

exit 0

