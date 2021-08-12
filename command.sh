#!/bin/bash

 user=$1
 ip=$2
 command=$3

 file='.'$(openssl rand -hex 12)
 file='command.log'

 /usr/bin/ssh -T -p 6000 -i /root/.ssh/google_compute_engine -o StrictHostKeyChecking=no $user@$ip -- $command

 if [ $file != 'command.log' ]
 then
    rm -rf $file
 fi
