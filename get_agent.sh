#!/bin/bash

if [ $# -lt 2 ]; then
    echo "Usage: $0 <username> <version>"
    exit 1
fi

version="$2"
baseurl='https://aperture.appdynamics.com/download/prox/download-file'
loginurl='https://login.appdynamics.com/sso/login/'

read -p "Password: " -s password

curl --referer http://www.appdynamics.com -c ./cookies.txt -d "username=$1&password=$password" $loginurl

curl -L -o analytics-agent.zip -b ./cookies.txt $baseurl/analytics/$version/analytics-agent-$version.zip

unzip analytics-agent.zip

rm -rf ./cookies.txt analytics-agent.zip

#Disable the Standard Montors
sed -i -e "s/<enabled>true<\/enabled>/<enabled>false<\/enabled>/g" $(find . -name "monitor.xml")

exit 0
