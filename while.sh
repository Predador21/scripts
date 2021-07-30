#!/bin/bash

while true
do
  ./kill_tmux.sh
  ./loop_make_tmux.sh
  ./tmux_send.sh
  sleep 1
done
