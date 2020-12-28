#!/bin/bash
# DESC : FCM PUSH TEST
# DATE : 20200610
# USER : YOON
################################

# Testing on two devices
# send message :  priority=high, P_CUST_CTN=01080666754, P_INSERT_DATE=20180529100243, VIEW_NUM=01075509229, MSG_TYPE=VIEW, CUST_KEY=1527555764549, PUSH_TYPE=1, TITLE=[m⁺CAM] 영상 수신 서비스, MESSAGE=01080666754|한상배 주임|FA 장비7반|FA_장비7반로 부터 수신 받은 영상을 확인하시겠습니까?, REQUEST_TIME=20180529100244549


# REG_ID 
REG_ID_0=""
REG_ID_1=""
AUTH=""

. ~/_config 

curl -v -k https://fcm.googleapis.com/fcm/send \
		 -H 'Content-Type: application/json' \
		 -H 'Authorization: key='${AUTH}'' \
		 -d "$(printf '{ "priority" : "high", 
		       "registration_ids": ["'${REG_ID_0}'", "'${REG_ID_1}'"] , 
		       "data": { 
				"P_CUST_CTN" : "01033579895", 
				"P_INSERT_DATE" : "20200610114030", 
				"VIEW_NUM" : "01022331362", 
				"VIEW_CTN_DEVICE" : "5212157f4f7464bc", 
				"MSG_TYPE" : "WAKEUP", 
				"PIN_CODE" : "1111", 
				"CUST_KEY" : "1591766020962", 
				"HOST_ID" : "01022336836", 
				"TITLE" : "[공지] PUSH 수신 시험", 
				"MESSAGE" : "발신:01022331111(홍길동)\r\n(%s)"
				"REQUEST_TIME" : "20200601150000" 
				}
		}' "`date "+%Y-%m-%d %H:%M:%S"`")"

echo ""
echo "END"
echo ""

exit
