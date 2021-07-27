#!/bin/bash

expiration=60

session_name=($(tmux list-sessions -F "#{session_name}"))
session_created=($(tmux list-sessions -F "#{session_created}"))

i=0

while [ $i -lt ${#session_name[@]} ]
do

 datetime=$(date '+%s')
 limite=$((datetime-expiration))

 if [[ ${session_name[i]} =~ "FENIX_" ]] && [ ${session_created[i]} -lt $limite ]
 then
    tmux kill-window -t ${session_name[i]} > /dev/null

    session=${session_name[i]/FENIX_/}

    mysql --login-path=$home/config.cnf fenix << EOF

     update tbl_session set status = 9 where session = '$session' and status = 2 ;

EOF

    echo "Session" ${session_name[i]} "finalizada por time-out (9)."
 fi

  ((i++))
done
