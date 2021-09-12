#!/bin/bash

filename='file.txt'
n=1
while read line;
do

account="'"$line"'"

query=$(mysql --login-path=$home/config.cnf fenix -se "select id from tbl_account where account = $account" )
read id <<< $query


if [ -z $id ]
then

source get-refresh_token.sh $line

mysql --login-path=$home/config.cnf fenix << EOF

    insert into tbl_account ( account, refresh_token, ativo ) values ('$line' , '$refresh_token' , 'F' ) ;

EOF

./command.sh $line $refresh_token

echo $line 'ok!'

#echo $refresh_token

fi

n=$((n+1))
done < $filename
