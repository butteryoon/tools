#!/bin/bash

DUCKDNS_TOKEN=''
SLACK_TOKEN_BUTTERYOON=''

. ~/_config

# duckdns.org
echo url="https://www.duckdns.org/update?domains=softroom.duckdns.org&token=${DUCKDNS_TOKEN}&ip=" | curl -k -o ~/log/check_public.sh.log -K -

# ipify.org
curIPAddress=`curl 'https://api.ipify.org?format=text'`
lastIPAddress=`cat ~/log/publicIPAddress.dat`

echo $curIPAddress $lastIPAddress

if [ $curIPAddress != $lastIPAddress ];then
    echo "${curIPAddress}" > ~/log/publicIPAddress.dat

    # slack post
    curl -H "Content-Type: application/json" \
        --location --request POST ${SLACK_TOKEN_BUTTERYOON} \
        --data-raw "$(printf '{
            "text": "Information public IP Address.",
            "blocks": [
                {
                    "type": "section",
                    "text": {
                        "type": "mrkdwn",
                        "text": "%s Your Public IP Address is %s"
                    }
                }
            ]
         }' ":earth_asia:" "${curIPAddress}")"
fi

exit
