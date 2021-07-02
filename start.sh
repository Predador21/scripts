#/bin/bash

tmux new -s $1 -d 'gcloud auth login --quiet'

./capturar_url.sh $1

url=$(cat $1.url)
echo ${url:48:657} > $1.url

link=$(cat $1.url)

mysql --login-path=$home/config.cnf fenix << EOF
INSERT INTO tbl_url (session,url) VALUES ('$1','$link');
EOF

rm -rf $1.url
