#!/bin/bash

gcloud info

echo /tmp/tmp*/ | xargs -n 1 cp -v /home/g0803211625/credentials.db

gcloud config set account g1003211329@gmail.com

while true
do
gcloud cloud-shell ssh --command="date" --authorize-session --force-key-file-overwrite --quiet >> log
sleep 60
done
