#!/bin/bash

 user=$1
 ip=$2
 command=$3

 /usr/bin/ssh -T -p 6000 -i google_compute_engine -o StrictHostKeyChecking=no $user@$ip -- $command
