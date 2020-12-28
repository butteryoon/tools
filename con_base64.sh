
#!/bin/sh

filename=$2

case $1 in 
enc)
	base64 -w 0 ${filename} > ${filename}.base64
	;;

dec)
	base64 -d DSC_0251.base64 > DSC_0251.JPG
	;;
*)
	;;
esac

exit

