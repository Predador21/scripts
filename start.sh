#/bin/bash

session=$1

tmux kill-window -t $session 2>/dev/null

tmux new -s $session -d 'gcloud auth login --quiet'

./capturar_url.sh $session

url=$(cat $session.url)
echo ${url:48:657} > $session.url

link=$(cat $session.url)

mysql --login-path=$home/config.cnf fenix << EOF

 insert into tbl_url (session,account,url,status) values ('$session','$2','$link','1');

 update tbl_session set status = 2 where account = '$2' ;

#1 = SEM TMUX
#2 = TMUX ABERTO COM URL CAPTURADA
#3 = CONCLUIDO
#9 = SESSION ENCERRADA - TIME OUT

EOF

rm -rf $session.url
