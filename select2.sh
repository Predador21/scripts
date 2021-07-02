#!/bin/bash

read -ra query <<< $(mysql --login-path=config.cnf fenix -se "select id , dataHora from tbl_url where id = 6")
echo ${query[0}
