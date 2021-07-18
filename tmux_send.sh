#!/bin/bash

session=($(tmux list-sessions -F "#{session_name}"))

i=0

while [ $i -lt ${#session_name[@]} ]
do

 if [[ ${session_name[i]} =~ "FENIX_" ]]
 then

    token=0 ;

    tmux send -t ${session[i]} $token C-m
    echo "Session" ${session[i]} "autorizada."
 fi

  ((i++))
done
