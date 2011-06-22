#!/bin/bash
echo "starting backup"
echo "log into joyent & creating backup"
DATE=`date +%Y-%m-%d--%k-%M`
ssh node@72.2.126.80 'mongo/bin/mongodump -o dump'$DATE'; exit;'
echo "downloading backup"
scp -r 'node@72.2.126.80:/home/node/dump'$DATE ./data/backup
echo "finish"
exit