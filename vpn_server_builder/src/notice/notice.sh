#!/bin/bash

VPN_IP_ADDR=`curl https://ip.motya.site`
USER_NAME=$1
VPN_USER_PW_ARN=$2
VPN_KEY_ARN=$3
NOTICE_TYPE=$4
NOTICE_TOKEN=$5

# get secret String
VPN_USER_PW=`aws secretsmanager get-secret-value --secret-id ${VPN_USER_PW_ARN} | jq '.SecretString' | jq -r . | jq -r '.password'`
VPN_KEY=`aws secretsmanager get-secret-value --secret-id ${VPN_KEY_ARN} | jq '.SecretString' | jq -r . | jq -r '.password'`

/bin/python3 /tmp/notice.py  ${VPN_IP_ADDR} ${USER_NAME} ${VPN_USER_PW} ${VPN_KEY} ${NOTICE_TYPE} ${NOTICE_TOKEN}
