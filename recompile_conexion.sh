#!/bin/bash -xe
DATE=`date +"%Y%m%d-%H%M%S"`
FILE=conexiones-$DATE.txt
cd /opt/test-appgate-main/logs
cat access_log | awk '{ print $1 }' | sort | uniq -c | sort -n > $FILE
