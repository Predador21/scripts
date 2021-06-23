#!/bin/bash

query=$(mysql --login-path=config.cnf fenix -se "select id , dataHora from tbl_url where id = 6")
echo $query
read id dataHora <<< $query

echo $id
echo $dataHora
