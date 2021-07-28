#!/bin/bash

session_name=($(tmux list-sessions -F "#{session_name}"))

i=0

while [ $i -lt ${#session_name[@]} ]
do

if [[ ${session_name[i]} =~ "FENIX_" ]]
then

    #session=${session_name[i]/FENIX_/}

    session=${session_name[i]}

    query=$(mysql --login-path=$home/config.cnf fenix -se "select token from tbl_url where status = 2 and id = (select max(id) from tbl_url where session = '$session' >

    read token <<< $query

    if [ "$token" ] && [ "$token" != "*" ]
    then

       tmux send -t ${session_name[i]} $token C-m

       echo "token: "$token

       #UPDATE PARA STATUS 3

       #VERIFICACAO GCLOUD AUTH LIST
       echo "Session" ${session_name[i]} "autorizada."

   fi

fi

  ((i++))
done
