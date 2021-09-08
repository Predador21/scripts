#!/bin/bash

while read account refresh_token
do

 ./command.sh $account

done < <(echo "select account , refresh_token from tbl_account " | mysql --login-path=$home/config.cnf fenix -s)
