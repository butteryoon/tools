#!/bin/sh
# DATE : 2016.10.06
#

case $1 in
conn)
echo watch -n 1 "netstat -anp | egrep 'State|172.16.1|10.0.0|192.168.20.'"
watch -n 1 "netstat -an | egrep 'State|172.16.1.|10.0.0'"
;;
phone)
echo watch -n 1 "netstat -anp | egrep 'State|172.16.1'"
watch -n 1 "netstat -an | egrep 'State|172.16.1.'"
;;
port)
echo watch -n 1 "netstat -anp | egrep 'LISTEN '"
watch -n 1 "netstat -anp | egrep 'LISTEN '"
;;
*)
echo "Usage $0 [conn|phone]"
echo "conn	: VPN 터널링된 단말, PC 세션"
echo "phone	: VPN 터널링된 단말 세션"
echo "port	: 포트사용 프로세스 보기"
;;
esac

exit
