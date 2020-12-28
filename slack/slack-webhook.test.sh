#!/bin/bash
# curl -v -H "Content-Type: application/json" --request POST https://hooks.slack.com/services/CHaNnel/TOKEN --data-raw '{ "text": "test message"}'
#

#
# Checking parameters 
# 
if [ $# -lt 2 ];then
	echo "$0 slack_id or channel api-function" 
	exit 
else
	. ~/_config 
	
	case $1 in
		butteryoon)
			SLACK_SERVER_URL=${SLACK_TOKEN_BUTTERYOON}
			;;
		general)
			SLACK_SERVER_URL=${SLACK_TOKEN_GENERAL}
			;;
	esac

fi


#
# main loop 
# 

case "$2" in 

command) 
	echo -n "input command : "
	read command_string

	curl -v -H "Content-Type: application/json" \
		--location --request POST ${SLACK_SERVER_URL} \
		--data-raw "$(printf '{ "text": " %s " }' "`${command_string}`")"
	;; 

addpost) 

		curl -v -H "Content-Type: application/json" \
			--location --request POST ${SLACK_SERVER_URL} \
			--data-raw '{ 
				"text": "Danny Torrence left a 1 star review for your property.",
				"blocks": [
				{
					"type": "section",
					"text": {
						"type": "mrkdwn",
						"text": "Danny Torrence left the following review for your property:"
					}
				},
				{
					"type": "section",
					"block_id": "section567",
					"text": {
						"type": "mrkdwn",
						"text": "<https://example.com|Overlook Hotel> \n :star: \n Doors had too many axe holes, guest in room 237 was far too rowdy, whole place felt stuck in the 1920s."
					},
					"accessory": {
						"type": "image",
						"image_url": "https://img.shields.io/endpoint?url=https://butteryoon.github.io/badges/samples.json",
						"alt_text": "Haunted hotel image"
					}
				},
				{
					"type": "section",
					"block_id": "section789",
					"fields": [
					{
						"type": "mrkdwn",
						"text": "*Average Rating*\n1.0"
					}
					]
				}
			]
		}'
		;;
*)
	echo "$0 api_name"
	echo "API LIST : 
		addpost : posting sample to slack channel
		command : posting result command line to slack channel
	"
	;;
esac


exit 0
