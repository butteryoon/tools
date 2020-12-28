#!/bin/bash
# DESC : COVID19 확진자 일일 보고
# dash : String array 지원안함. 
# DATE : 20200904
# curl http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19InfStateJson\?serviceKey\=SERVICE_KEY\&pageNo\=1\&numOfRows\=10\&startCreateDt\=20200903\&endCreateDt\=20200904  | xmllint --format  - 
# 
# xmllint를 이용하여 특정 Element 가져오기
# sudo apt install libxml2-utils
# xmllint --xpath '/response/body/items/item/decideCnt/text()' --format -`

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    StartDate=`date -d '8 day ago' +%Y%m%d`
    EndDate=`date -d '1 day ago' +%Y%m%d` 
elif [[ "$OSTYPE" == "darwin"* ]]; then
    StartDate=`date -v -8d +%Y%m%d`
    EndDate=`date -v -1d +%Y%m%d` 
else
    echo "Uknown OSTYPE : $OSTYPE"
    exit
fi


# VARIABLES
COVID_OPENAPI_URL=''
COVID_SERVICE_KEY=''
SLACK_SERVER_BUTTER=""
SLACK_SERVER_GENERAL=""

. ~/_config 

#
# get contents
#
getContent() {
	curl ${COVID_OPENAPI_URL}\?serviceKey\=${COVID_SERVICE_KEY}\&pageNo\=1\&numOfRows\=10\&startCreateDt\=${StartDate}\&endCreateDt\=${EndData} | xmllint --format - > ~/log/output.xml
}

# Check Date
checkDate() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	    DATESTR=`date -d '0 day ago' +%Y-%m-%d`
    elif [[ "$OSTYPE" == "darwin"* ]]; then
	    DATESTR=`date -v -0d  +%Y-%m-%d`
    else
        echo "Uknown OSTYPE : $OSTYPE"
        exit
    fi


	RESULT=`grep ${DATESTR} ~/log/output.xml -c`

	if [ $RESULT -eq 1 ];then
		return 200
	else
		echo `date '+%Y-%m-%d %H:%M:%S'` "${DATESTR} not found" > ~/log/result.log
		return 404
	fi
}


#
# parsing 
#
runParsing() {
	TEXT_BODY=`cat ~/log/output.xml | egrep 'createDt|decideCnt' | tr '\n' ' ' | sed s/"<\/createDt>"/""/g | sed s/"<\/decideCnt>"/""/g | sed s/"<"/""/g | sed s/">"/" : "/g | sed s/createDt/"\ncreateDt"/g | sort | awk -F: 'BEGIN {ENC=0} {ENC=$5-CNT} {print $2":"$3" "$5" "ENC} {CNT=$5}' | tail -n7`   
	echo `date '+%Y-%m-%d %H:%M:%S'` "runParsing() return [${TEXT_BODY}]" >> ~/log/result.log
}

#
# make text body
#
makeBody() {
	HEADER=" :helmet_with_white_cross: *`echo "$TEXT_BODY" | grep $DATESTR | awk '{print $1" "$2" 기준 확진자 증가자 수는 "$4}'`명 입니다.*\n\n"
	echo `date '+%Y-%m-%d %H:%M:%S'` "makeBody() return [${HEADER}]" >> ~/log/result.log
}

# echo $HEADER
sendSlackChannel() {
curl -v -H "Content-Type: application/json" \
    --location --request POST ${SLACK_SERVER_BUTTERYOON} \
    -d "$(printf '{ 
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
}

#
# MAIN 
#
while true
do
	getContent
	checkDate
	if [ $? -eq 200 ];then
		runParsing
		makeBody
		sendSlackChannel
		echo `date '+%Y-%m-%d %H:%M:%S'` "end script" >> ~/log/result.log
		exit
	else
		sleep 600
	fi
done
