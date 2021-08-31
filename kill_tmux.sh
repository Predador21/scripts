#!/bin/bash

expiration=3600

session_name=($(tmux list-sessions -F "#{session_name}"))
session_created=($(tmux list-sessions -F "#{session_created}"))

i=0

while [ $i -lt ${#session_name[@]} ]
do

 datetime=$(date '+%s')
 limite=$((datetime-expiration))

 session=${session_name[i]}

 if [[ $session =~ "fenix_" ]] && [ ${session_created[i]} -lt $limite ]
 then

    tmux kill-window -t $session > /dev/null

    mysql --login-path=$home/config.cnf fenix << EOF

      update tbl_session set status = 9 where session = '$session' and status = 2 ;

      update tbl_url set status = 9 where session = '$session' and status = 1 ;

EOF
    echo
    echo "Session" $session "finalizada por time-out (9)."
 fi

  ((i++))
done
