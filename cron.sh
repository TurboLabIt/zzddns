#!/usr/bin/env bash
echo ""

SCRIPT_NAME=zzddns
source "/usr/local/turbolab.it/bash-fx/bash-fx.sh"
fxHeader "🕛 ${SCRIPT_NAME} cron"
rootCheck
fxMessage "The output is redirect to logfile, please wait..."

LOG_DIR="/var/log/turbolab.it/"
mkdir -p "${LOG_DIR}"
LOG_FILE=${LOG_DIR}${SCRIPT_NAME}_cron.log

bash "/usr/local/turbolab.it/${SCRIPT_NAME}/${SCRIPT_NAME}.sh" "$1" >> "${LOG_FILE}" 2>&1

fxTitle "${LOG_FILE}"
cat ${LOG_FILE}
