#!/bin/bash

COUNT=1
TIMETOSLEEP=300
MAILTO="YOURMEILA@YOURDOMAIN.COM"
SUBJECT="Rsync backup YOURSERVER HOSTNAME"
FROM="Rsync Hosting <rsync@YOURDOMAIN.COM>"
export RSYNC_PASSWORD="YOURPASSWORD OF RSYNC"
TORUN="rsync -r --delete --progress /var/lib/vz/dump/ rsync://YOUR_RSYNC_ADDRESS/YOUR_DEST_PATH/"

# Launch command
command=$( { ${TORUN}; } 2>&1 )

# While error
while [ "$?" -ne 0 ]
do
	COUNT=$(( COUNT + 1 ))
	sleep $TIMETOSLEEP
	command=$( { ${TORUN}; } 2>&1 )
done


{
    echo "Subject: ${SUBJECT}"
    echo "From: ${FROM}"
    echo ""
    echo "After ${COUNT} try:"
    echo "${command}"
} | /usr/sbin/sendmail -t $MAILTO