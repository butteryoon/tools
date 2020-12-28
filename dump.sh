#!/bin/sh

if [ $# -lt 1 ];then
	echo ""
	echo "Usage : $0 ipaddress"
	echo ""
	exit
fi

HOST=$1

FILENAME=${HOST}_`date +%m%d%H%M%S`.pcap

tshark -S -i eth5 host ${HOST} -w ${FILENAME}

# MOVE
chown lcsapp.lcsapp $FILENAME
mv $FILENAME ~lcsapp/dump/

# INFO
echo FILE : ls -l ~lcsapp/dump/${FILENAME}

exit
