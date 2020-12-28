#!/bin/sh
# DATE : 2020-05-25

case $1 in 
timet)
    echo -n "Type unix time ex) 1590395305 : "
    read TIME_T
    date -d @${TIME_T} "+%Y-%m-%d %H:%M:%S"
;;
str) 
    echo -n "Type date string ex) 2020-05-25 18:00:00 : "
    read DATESTR
    date -d "${DATESTR}" +%s
;;
cur) 
    date '+%Y-%m-%d %H:%M:%S'
    date +%s
;;

*)
    echo "Usage : $0 [timet|str|cur]"
;;
esac

exit
