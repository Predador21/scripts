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

       tmux send -t $session $token C-m

       echo "token: "$token

       mysql --login-path=$home/config.cnf fenix << EOF

         update tbl_session set status = 3 where session = '$session' and status = 2 ;

         update tbl_url set status = 3 where token = '$token' and status = 2 ;

EOF
       #VERIFICACAO GCLOUD AUTH LIST
       echo "Session" ${session_name[i]} "autorizada."

   fi

fi

  ((i++))
done
