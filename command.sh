#!/bin/bash

 user=$1
 ip=$2
 command=$3

 /usr/bin/ssh -T -p 5000 -i /root/.ssh/google_compute_engine -o StrictHostKeyChecking=no $user@$ip -- $command
