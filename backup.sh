#!/bin/bash

file='backup_'$(date +"%d%m%Y%H%M%S")'.zip'

rm -rf /root/.config/gcloud/mysql.sql ; mysqldump --defaults-file=/root/make_gmail/config.cnf fenix > /root/.config/gcloud/mysql.sql

rm -rf /root/.config/gcloud/logs/*

zip -r -q ~/$file /root/.config/gcloud/

cp ~/$file /mnt/share

rm -rf ~/$file
