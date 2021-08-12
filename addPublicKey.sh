#!/bin/bash

 file='.'$(openssl rand -hex 12)
 file='addPublicKey.log'

 curl -s --request POST \
         --url 'https://cloudshell.googleapis.com/v1/users/me/environments/default:addPublicKey?alt=json' \
         --header 'Authorization: Bearer '$1'' \
         --header 'Accept: application/json' \
         --header 'Content-Type: application/json' \
         --data   '{"key":"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDOs+97X93pwoFQziE0sXuK+oYo1lBwybBS2c7OlwxWg7kenKfZti/YP6eg5dxakOJG9ZOTT2d34iiRGTIABaRXUXXc/6e7TmdM/BGu7BzD0zokDzIlNXGLKqjf5Yn5hH3kn4n21EawUBaEwmzg6Cpii1XKxJgETxMG9VhUovKXlv2yl96dUGizHpx7Wq2EzsbcUnwhVkDBCQr4HaMFMajOrt4h351o/L4YPT1cPlCxiaDWDhY/UnUOaEwhyZG5e26o9yZ0qNf4r5tzmy0RBRxpJ5bQtKxaZ5cO/kQGLSIXh+Gvb/beftE0Av86dfdGZSvtLheR5jIgZz1sjtIYGK/0hEmE7M26WkY/lhWRYA+D+HEPwuEmw+t4mnyEwgQt5wJUIJryxqtrltITqUKx6d+QkFhP95bKIqePfGg7NfgF0agzIP8aAdb6ABQDK1JVEXc1JLE8xE9z96ZO07q5Wj7n0iob1ogXb7KP8Mh1gN350+odHvFKgXVTMv30VkqOTV8="}' \ > $file

 result=$(jq '.done' $file)
 result=${result//'"'/}

 if [ $file != 'addPublicKey.log' ]
 then
    rm -rf $file
 fi

 if [ $2 ]
 then
    echo $result
 fi
