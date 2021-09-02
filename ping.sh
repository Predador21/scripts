#!/bin/bash

while true
do
   curl http://135.148.11.148/ping.php?account=$1
   sleep $2
done
