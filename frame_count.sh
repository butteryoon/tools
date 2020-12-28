#!/bin/sh
#
# FORMAT .. 
# [20200420-11:22:58] video frame[00001] in[2739056.312000] out[2739056.343000] diff[0.031000] 
# PARAMETER .. 
# $1 : 20200420-11:22:58
# $2 : 0.031000
################################################################################################

filename=$1

cat ${filename} | grep video | tr "[" " " | tr "]" " " | awk 'BEGIN {} {ITEM[$1]++} {TIME[$1]+=$10} {if (IN[$1] == "") IN[$1]=$6} {OUT[$1]=$6} END {for (i in ITEM) print i, ITEM[i], TIME[i], IN[i], OUT[i], OUT[i] - IN[i]}' | sort -k1


exit
