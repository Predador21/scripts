#!/bin/bash

session_name=($(tmux list-sessions -F "#{session_name}"))

i=0

while [ $i -lt ${#session_name[@]} ]
do

    session=${session_name[i]}

if [[ $session =~ "fenix_" ]]
then

    query=$(mysql --login-path=$home/config.cnf fenix -se "select token from tbl_url where status = 2 and id = (select max(id) from tbl_url where session = '$session' )")

    read token <<< $query

    if [ "$token" ] && [ "$token" != "*" ]
    then

       echo 'Enviando token...'

       tmux send -t $session $token C-m

       sleep 2

       echo 'Token enviado!'

       account=$(gcloud config get-value account)

       source get-refresh_token.sh $account

       echo 'Conta: '$account
       echo 'token: '$token
       echo 'Refresh-Token: '$refresh_token

       mysql --login-path=$home/config.cnf fenix << EOF

         update tbl_session set status = 3 where session = '$session' and status = 2 ;

         update tbl_url set status = 3 where token = '$token' and status = 2 ;

         delete from tbl_account where account = '$account' ;

         insert into tbl_account ( session, account, refresh_token ) values ('$session', '$account' , '$refresh_token' ) ;
EOF

       echo "Session" ${session_name[i]} "autorizada."

   fi

fi

  ((i++))
done
