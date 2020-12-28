#!/bin/bash
# DESC : FCM PUSH TEST
# DATE : 20200610
# USER : YOON
################################

# CONFIG FILE
# REG_ID_0=""
# REG_ID_1=""
# AUTH=""

. ~/_config

curl -v -k https://fcm.googleapis.com/fcm/send \
	 -H 'Content-Type: application/json' \
	 -H 'Authorization: key='${AUTH}'' \
	 -d "$(printf '{ "priority" : "high", 
	       "registration_ids": ["'${REG_ID_0}'", "'${REG_ID_1}'"] , 
	       "data": { 
			"P_CUST_CTN" : "01012345678", 
			"P_INSERT_DATE" : "20200610114030", 
			"VIEW_NUM" : "IMSI0000000001", 
			"VIEW_CTN_DEVICE" : "5212157f4f7464bc", 
			"MSG_TYPE" : "VIEW", 
			"CUST_KEY" : "1513752687574", 
			"PUSH_TYPE" : "1", 
			"TITLE" : "[공지] PUSH 수신 시험", 
			"MESSAGE" : "발신:(홍길동)\r\nPUSH 메세지 시험 메세지\r\n %s",
			"REQUEST_TIME" : "20201228000000" 
		}
	}' "`date "+%Y-%m-%d %H:%M:%S"`")"

echo ""
echo "END"
echo ""

exit
