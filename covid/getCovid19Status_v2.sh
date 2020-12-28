#!/bin/bash
# DESC : COVID19 확진자 일일 보고
# dash : String array 지원안함. 
# DATE : 20200904
# curl http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19InfStateJson\?serviceKey\=NsIHAIJjEw2BvegVdEL7AnpK6PbXWs%2FW1QYN%2FWxGfht1jFN2qO2E8ojMn1FIV%2BjHi3PGWWOO7ZN7mHQCdIoRbw%3D%3D\&pageNo\=1\&numOfRows\=10\&startCreateDt\=20200903\&endCreateDt\=20200904  | xmllint --format  - 
# 
# xmllint를 이용하여 특정 Element 가져오기
# xmllint --xpath '/response/body/items/item/decideCnt/text()' --format -`

StartDate=`date -d '8 day ago' +%Y%m%d`
EndDate=`date -d '0 day ago' +%Y%m%d` 

# VARIABLES
COVID_OPENAPI_URL=''
COVID_SERVICE_KEY=''
SLACK_SERVER_BUTTER=""
SLACK_SERVER_GENERAL=""

. ~/_config 

curl ${COVID_OPENAPI_URL}\?serviceKey\=${COVID_SERVICE_KEY}\&pageNo\=1\&numOfRows\=10\&startCreateDt\=${StartDate}\&endCreateDt\=${EndData} | xmllint --format - > output.xml

TEXT_BODY=`cat output.xml | egrep 'createDt|decideCnt' | tr '\n' ' ' | sed s/"<\/createDt>"/""/g | sed s/"<\/decideCnt>"/""/g | sed s/"<"/""/g | sed s/">"/" : "/g | sed s/createDt/"\ncreateDt"/g | sort | awk -F: 'BEGIN {ENC=0} {ENC=$5-CNT} {print $2":"$3" "$5" "ENC} {CNT=$5}' | tail -n7`  

DATESTR=`date -d '0 day ago' +%Y-%m-%d`
HEADER=" :helmet_with_white_cross: *`echo "$TEXT_BODY" | grep $DATESTR | awk '{print $1" "$2" 기준 확진자 증가자 수는 "$4}'`명 입니다.*\n\n"

# echo $HEADER

curl -v -H "Content-Type: application/json" \
    --location --request POST ${SLACK_SERVER_BUTTER} \
    --data-raw "$(printf '{ 
                "text": "Information covid19.",
                "blocks": [
                {
					"type": "section",
					"text": {
						"type": "mrkdwn",
						"text": "%s"
					}
				}, 
                {
                    "type": "divider"
                },
                {
					"type": "section",
					"text": {
						"type": "mrkdwn",
						"text": "일자                        확진자수    전일대비\n%s"
					}
				},
                {
					"type": "section",
					"text": {
						"type": "mrkdwn",
						"text": "출처 : <https://www.data.go.kr/tcs/dss/selectApiDataDetailView.do?publicDataPk=15043376|보건복지부_코로나19 감염_현황>"
					}
				},

                ]
        }' "${HEADER}" "${TEXT_BODY}")" 
