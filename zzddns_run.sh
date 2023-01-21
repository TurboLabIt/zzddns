#!/usr/bin/env bash

SCRIPT_NAME=zzddns
source "/usr/local/turbolab.it/bash-fx/bash-fx.sh"
fxHeader "🧭 ${SCRIPT_NAME}"
rootCheck

fxConfigLoader "$1"


fxTitle "Current profile"
ZZDDNS_PASSWORD_HIDDEN=$(fxPasswordHide "${ZZDDNS_PASSWORD}")

echo "🏢 DDNS Provider:    ##${ZZDDNS_PROVIDER}##"
echo "👤 Username:         ##${ZZDDNS_USERNAME}##"
echo "🔑 Pass:             ##${ZZDDNS_PASSWORD_HIDDEN}##"
echo "📛 Domain:           ##${ZZDDNS_DOMAIN}##"


if [ -z "$1" ]; then
  IP_FILE="${ZZDDNS_DOMAIN}"
else 
  IP_FILE="${ZZDDNS_DOMAIN}-$1"
fi


fxCheckIpAddressChanged "${IP_FILE}"
if [ -z "$FX_NEW_IP_ADDRESS" ]; then
  fxEndFooter
  exit
fi


if [ "$ZZDDNS_PROVIDER" = "duckdns" ]; then
  
  fxTitle "🦆 DuckDNS update for ##$ZZDDNS_DOMAIN##..."
  CURL_RETRIVED_PAGE=$(curl -Ls "https://www.duckdns.org/update?domains=${ZZDDNS_DOMAIN}&token=${ZZDDNS_PASSWORD}&ip=")
  CURL_RESULT="$?"
  
  if [ "$CURL_RESULT" != 0 ] || [ "${CURL_RETRIVED_PAGE}" != "OK" ]; then
  
    echo "" > "${IP_FILE}"
    fxCatastrophicError "CURL error ##${CURL_RESULT}## | Page output: #${CURL_RETRIVED_PAGE}# "
  fi
  
  fxOK "Success! CURL returned ##${CURL_RESULT}## | Page output: #${CURL_RETRIVED_PAGE}# "
  
else

  fxCatastrophicError "DDNS provider ##$ZZDDNS_PROVIDER## is unknown"
fi


fxTitle "Updating the IP file..."
echo "${FX_NEW_IP_ADDRESS}" > "${FX_IP_ADDRESS_FILE}"
cat "${FX_IP_ADDRESS_FILE}"

fxEndFooter

