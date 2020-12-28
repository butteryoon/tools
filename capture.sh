#!/bin/sh

case $1 in
net)
echo tshark -t ad -i eth5 net 172.16.1.0/24 -w LCS_172.16.1.0.pcap
tshark -t ad -i eth5 net 172.16.1.0/24 -w LCS_172.16.1.0.pcap
chown lcsapp.lcsapp LCS_172.16.1.0.pcap
mv LCS_172.16.1.0.pcap /home/lcsapp/
;;
signal)
echo tshark -t ad -i eth5 port 15490 -w signal.pcap
tshark -t ad -i eth5 port 15490 -w signal.pcap
chown lcsapp.lcsapp signal.pcap
mv signal.pcap /home/lcsapp/
;;
6681)
echo tshark -t ad -i eth5 port 6681
tshark -t ad -i eth5 port 6681
;;
6682)
echo tshark -t ad -i eth5 port 6682
tshark -t ad -i eth5 port 6682
;;
6683)
echo tshark -t ad -i eth5 port 6683
tshark -t ad -i eth5 port 6682
;;
send)
echo tshark -t ad -i eth5 port 38000
tshark -t ad -i eth5 port 38000
;;
host)
echo tshark -t ad -i eth5 host $2 -w capture.pcap
tshark -t ad -i eth5 host $2 -w LCS_$2.pcap
chown lcsapp.lcsapp LCS_$2.pcap
mv LCS_$2.pcap /home/lcsapp/
;;
svc)
echo tshark -t ad -i eth5 host $2 and port $3 -w LCS_$2_$3.pcap
tshark -t ad -i eth5 host $2 and port $3 -w LCS_$2_$3.pcap
chown lcsapp.lcsapp LCS_$2_$3.pcap
mv LCS_$2_$3.pcap /home/lcsapp/
;;
*)
echo "Usage $0 [signal|6681|6682|6683|host|svc]"
echo "signal	: port 15490"
echo "6681	: 1:1 영상"
echo "6682	: 4:1 영상"
echo "6683	: 4:1 영상"
echo "send	: 단말발신영상"
echo "host	: 특정단말IP"
echo "svc	: 특정단말IP+Port"
echo "net	: 모든단말"
;;
esac

exit
