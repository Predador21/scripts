#!/bin/bash

echo
echo $1

#Define nome do arquivo de backup
file='backup_'$(date +"%d%m%Y%H%M%S")'.zip'

#Comando que será executado no gcloud SSH
command="[ ! -e '.customize_environment' ] && ( wget -q https://raw.githubusercontent.com/Predador21/scripts/main/.customize_environment ; chmod 777 .customize_environ>

#gcloud SSH
gcloud cloud-shell ssh --account=$1 --command="$command" --authorize-session --force-key-file-overwrite --ssh-flag='-n' --quiet

#Backup MySQL
rm -rf /root/.config/gcloud/mysql.sql ; mysqldump --defaults-file=/root/make_gmail/config.cnf fenix > /root/.config/gcloud/mysql.sql

#Apaga logs gcloud
rm -rf /root/.config/gcloud/logs/*

#Zipa arquivos gcloud
zip -r -q ~/$file /root/.config/gcloud/

#Copia arquivo para pasta compartilhada
cp ~/$file /mnt/share

#Apaga arquivo
rm -rf ~/$file

#Envia para conta gcloud de backup
gcloud cloud-shell scp localhost:/root/$file cloudshell:~/.backup --account='backup.gcloud1@gmail.com' --force-key-file-overwrite

#Altera o status na tbl_account para CREATED
url='http://135.148.11.148/send_status.php?refresh='$2'&status=CREATED&owner=ROOT'
curl $url

echo 'command ok'
