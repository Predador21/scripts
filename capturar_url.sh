#!/bin/bash

rm -rf *.url

session=$1

url=$session.url

while true
  do

   tmux capture-pane -J -p -t $session > $url

   if grep -q "Enter verification code" $url ; then
      echo "url capturada!"
      break
   fi

   sleep 1

   echo "aguardando url..."

done
