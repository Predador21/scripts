#!/bin/bash

#suppress warning
mkdir  ~/.cloudshell
touch  ~/.cloudshell/no-apt-get-warning

sudo apt-get update
sudo apt-get --assume-yes install build-essential cmake libuv1-dev libssl-dev libhwloc-dev git unzip
