#!/bin/bash

DUCKDNS_TOKEN=''
SLACK_SERVER_BUTTERYOON=''

. ~/_config

# duckdns.org
echo url="https://www.duckdns.org/update?domains=examples.duckdns.org&token=${DUCKDNS_TOKEN}&ip=" | curl -k -o ~/log/check_public.sh.log -K -

# ipify.org
curIPAddress=`curl 'https://api.ipify.org?format=text'`

if [ -f ~/log/publicIPAddress.dat ];then
	lastIPAddress=`cat ~/log/publicIPAddress.dat`
else
	echo '0.0.0.0' > ~/log/publicIPAddress.dat
	lastIPAddress=`cat ~/log/publicIPAddress.dat`
fi

echo $curIPAddress $lastIPAddress

if [ $curIPAddress != $lastIPAddress ];then
    echo "${curIPAddress}" > ~/log/publicIPAddress.dat

    # slack post
    curl -H "Content-Type: application/json" \
        --location --request POST ${SLACK_SERVER_BUTTERYOON} \
        -d "$(printf '{
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
