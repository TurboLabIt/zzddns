#!/usr/bin/env bash
echo ""
SCRIPT_NAME=zzddns            

## bash-fx
if [ -z $(command -v curl) ]; then sudo apt update && sudo apt install curl -y; fi
curl -s https://raw.githubusercontent.com/TurboLabIt/bash-fx/master/setup.sh?$(date +%s) | sudo bash
source /usr/local/turbolab.it/bash-fx/bash-fx.sh
## bash-fx is ready

sudo bash /usr/local/turbolab.it/bash-fx/setup/start.sh ${SCRIPT_NAME}

fxLinkBin ${INSTALL_DIR}${SCRIPT_NAME}.sh

if [ ! -f "/etc/cron.d/${SCRIPT_NAME}" ]; then
  sudo cp "${INSTALL_DIR}cron" "/etc/cron.d/${SCRIPT_NAME}"
fi

sudo bash /usr/local/turbolab.it/bash-fx/setup/the-end.sh ${SCRIPT_NAME}
