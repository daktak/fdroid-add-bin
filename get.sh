#!/bin/bash
URL=$1
GPLAYDIR="/var/www/localhost/htdocs/fdroid-gp/repo/"
OTHERDIR="/var/www/localhost/htdocs/fdroid/repo/"
GPLAYCMD=/usr/bin/gplaycli
FDROIDCMD=/usr/bin/fdroid
TMPFILE=/tmp/fd-run.sh
if [[ "$URL" =~ ^https://play.google.com/.* ]]; then
	IFS='='
	array=( ${URL} ) 
	echo ${array[1]}
	echo "#!/bin/bash" > ${TMPFILE}
	echo "cd "${GPLAYDIR}"" >> ${TMPFILE}
	echo "${GPLAYCMD} -d ${array[1]}" >>  ${TMPFILE}
else
	echo $URL
	echo "cd "${OTHERDIR}"" >  ${TMPFILE}
	echo "wget "${URL}"" >> ${TMPFILE}
fi
echo "cd .." >>  ${TMPFILE}
echo "${FDROIDCMD} update -c --pretty" >>  ${TMPFILE}
/usr/bin/screen -dmS FDROID /bin/sh  ${TMPFILE}
