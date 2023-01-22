#!/usr/bin/env bash

function runOne()
{
  sudo -u root -H bash "/usr/local/turbolab.it/zzddns/zzddns_run.sh" "$@"
}


if [ "$1" = "default" ]; then
  
  runOne
  
elif [ ! -z "$1" ]; then

  runOne "$@"
  
else

  if [ -f "/etc/turbolab.it/zzddns.conf" ]; then
      runOne
  fi  

  for FILE_FULLPATH in /etc/turbolab.it/zzddns*.conf; do
    
    if [ "${FILE_FULLPATH}" != "/etc/turbolab.it/zzddns.conf" ]; then 
      
      PROFILE_NAME=$(basename "${FILE_FULLPATH}")
      PROFILE_NAME=${PROFILE_NAME#zzddns-}
      PROFILE_NAME=${PROFILE_NAME#zzddns.profile.}
      PROFILE_NAME=${PROFILE_NAME%.*}
      runOne "${PROFILE_NAME}"
      
    fi
    
  done
  
fi

