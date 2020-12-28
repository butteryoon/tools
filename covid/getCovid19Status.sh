#!/bin/bash
# DESC : COVID19 확진자 일일 보고
# dash : String array 지원안함. 

# VARIABLES
DATESTR=`date +%Y%m%d`
DATESTR=$DATESTR" "`date -d '1 day ago' +%Y%m%d`

# URL AND KEY
. ~/_config

# curl http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19InfStateJson\?serviceKey\=SERVICE_KEY\&pageNo\=1\&numOfRows\=10\&startCreateDt\=20200903\&endCreateDt\=20200904  | xmllint --format  - 

for date in $DATESTR
do
    RESULT=`curl ${COVID_OPENAPI_URL}\?serviceKey\=${COVID_SERVICE_KEY}\&pageNo\=1\&numOfRows\=10\&startCreateDt\=${date}\&endCreateDt\=${date} | xmllint --xpath '/response/body/items/item/decideCnt/text()' --format -`

    decideCnt+=" $RESULT"
done

echo ${decideCnt}

RESULT_CNT=`echo ${decideCnt} | awk '{CNT=$1-$2} END {print CNT}' `

echo $RESULT_CNT



curl -v -H "Content-Type: application/json" \
    --location --request POST ${SLACK_SERVER_BUTTERYOON} \
    --data-raw "$(printf '{ "text": " %s " }' "$RESULT_CNT")"


exit
