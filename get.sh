#!/bin/bash
URL=$1
GPLAYDIR="/var/www/locahost/htdocs/fdroid-gp/repo/"
OTHERDIR="/var/www/localhost/htdocs/fdroid/repo/"
GPLAYCMD=/usr/bin/gplaycli
if [[ "$URL" =~ ^https://play.google.com/.* ]]; then
	IFS='='
	array=( ${URL} ) 
	echo ${array[1]}
	cd "${GPLAYDIR}"
	${GPLAYCMD} -d ${array[1]}
else
	echo $URL
	cd "${OTHERDIR}"
	wget "${URL}"
fi
#cd ..
#python2 /usr/bin/fdroid update -c --pretty 
