#!/bin/bash

mysql --login-path=config.cnf fenix << EOF
INSERT INTO tbl_url (\`url\`) VALUES ("teste2");
EOF
