#/bin/bash

tmux new -s $1 -d 'gcloud auth login --quiet'

./capturar_url.sh $1

url=$(cat $1.url)
echo ${url:48:657} > $1.url

token=$(cat $1.url)

mysql --login-path=config.cnf fenix << EOF
INSERT INTO tbl_url (\`url\`) VALUES ('$token');
EOF


#tmux send -t $1 'XXXXXXXXXXXXXXXXXXXXXXXXXX' # C-m

rm -rf $1.url
