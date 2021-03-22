#!/bin/bash

sudo rm -rf echo /tmp/tmp*/credentials.db | xargs -n 1

gcloud info

echo /tmp/tmp*/ | xargs -n 1 cp -v /home/g1003211329/credentials.db

gcloud auth list

gcloud config set account g1203211109@gmail.com

while true
do
gcloud cloud-shell ssh --command="date >> log" --authorize-session --force-key-file-overwrite --quiet
sleep 60
done
