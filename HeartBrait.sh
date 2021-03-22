#!/bin/bash

#rm -rf log

sudo rm -rf echo /tmp/tmp*/credentials.db | xargs -n 1

gcloud info

echo /tmp/tmp*/ | xargs -n 1 cp -v /home/g0803211625/credentials.db

gcloud auth list

gcloud config set account g1003211329@gmail.com

while true
do
gcloud cloud-shell ssh --command="date" --authorize-session --force-key-file-overwrite --quiet >> log
sleep 60
done
