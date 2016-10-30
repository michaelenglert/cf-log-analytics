#!/bin/bash

if [ $# -lt 2 ]; then
    echo "Usage: $0 <username> <version>"
    exit 1
fi

version="$2"
baseurl='https://aperture.appdynamics.com/download/prox/download-file'

read -p "Event Service Host Name: " eventshostname
read -p "Event Service Port: " eventsport
read -p "Account Access Key: " accesskey
read -p "Global Account Name: " globalaccountname
read -p "Docker Image Name: " image_name
read -p "Portal Password: " -s password

docker build \
-q \
--build-arg HOST_NAME=$eventshostname \
--build-arg ACCESS_KEY=$accesskey \
--build-arg USER=$1 \
--build-arg PASSWORD=$password \
--build-arg BASEURL=$baseurl \
--build-arg VERSION=$2 \
--build-arg EVENTS_PORT=$eventsport \
--build-arg GLOBAL_NAME=$globalaccountname \
-t $image_name:$version .

exit 0
