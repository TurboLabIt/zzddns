#!/usr/bin/env bash

SCRIPT_NAME=zzddns
source "/usr/local/turbolab.it/bash-fx/bash-fx.sh"
fxHeader "🧭 ${SCRIPT_NAME}"
rootCheck

fxConfigLoader "$1"


fxTitle "Current profile"
echo "🏢 DDNS Provider:    ##${ZZDDNS_PROVIDER}##"
echo "👤 Username:         ##${ZZDDNS_USERNAME}##"
echo "🔑 Pass:             ##$(fxPasswordHide \"{ZZDDNS_PASSWORD}\")##"
echo "📛 Domain:           ##${ZZDDNS_DOMAIN}##"


if [ -z "$1" ]; then
  IP_FILE="${ZZDDNS_DOMAIN}"
else 
  IP_FILE="${ZZDDNS_DOMAIN}-$1"
fi


fxCheckIpAddressChanged "${IP_FILE}"


if [ -z "$FX_NEW_IP_ADDRESS" ]; then
  fxEndFooter
fi


if [ "$ZZDDNS_PROVIDER" = "duckdns" ]; then
  
  fxTitle "🦆 DuckDNS update for ##$ZZDDNS_DOMAIN##..."
  echo curl -L "https://www.duckdns.org/update?domains=${ZZDDNS_DOMAIN}&token${ZZDDNS_PASSWORD}&ip="
  
  if [ "$?" != 0 ]; then
    echo "${FX_NEW_IP_ADDRESS}" > "${IP_FILE}"
  fi

else

  fxCatastrophicError "DDNS provider ##$ZZDDNS_PROVIDER## is unknown"
fi


fxEndFooter

