#!/bin/bash

HUB_NAME=$1
HUB_PW_ARN=$2
VPN_USER_NAME=$3
VPN_USER_PW_ARN=$4
VPN_KEY_ARN=$5

# get secret String
HUB_PW=`aws secretsmanager get-secret-value --secret-id ${HUB_PW_ARN} | jq '.SecretString' | jq -r . | jq -r '.password'`
VPN_USER_PW=`aws secretsmanager get-secret-value --secret-id ${VPN_USER_PW_ARN} | jq '.SecretString' | jq -r . | jq -r '.password'`
VPN_KEY=`aws secretsmanager get-secret-value --secret-id ${VPN_KEY_ARN} | jq '.SecretString' | jq -r . | jq -r '.password'`

cd /usr/local/vpnserver/

printf "1\n\n\nHubCreate\n${HUB_NAME}\n${HUB_PW}\n${HUB_PW}\n" | ./vpncmd
printf "1\n\n\nHubDelete\nDEFAULT\n" | ./vpncmd
printf "1\n\n\nHUB ${HUB_NAME}\nUserCreate\n${VPN_USER_NAME}\n\n\n\n" | ./vpncmd
printf "1\n\n\nHUB ${HUB_NAME}\nUserPasswordSet\n${VPN_USER_NAME}\n${VPN_USER_PW}\n${VPN_USER_PW}\n" | ./vpncmd
printf "1\n\n\nHUB ${HUB_NAME}\nIPsecEnable\nyes\nno\nno\n${VPN_KEY}\n${HUB_NAME}\n" | ./vpncmd
printf "1\n\n\nHUB ${HUB_NAME}\nSecureNatEnable\n" | ./vpncmd
printf "1\n\n\nDhcpset Start:192.168.30.10 End:192.168.30.200 Mask:255.255.255.0 Expire:7200 GW:192.168.30.1 DNS:192.168.30.1 DNS2:none Domain:none Log:yes PushRoute:\"192.168.0.0 255.255.0.0 192.168.30.1\"" | ./vpncmd
