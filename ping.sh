#!/bin/bash

while pgrep xmrig > /dev/null
do
   curl http://135.148.11.148/ping.php?account=$1&version=$2
   sleep 60
done
