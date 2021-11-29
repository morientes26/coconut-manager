#!/usr/bin/env bash

# Stop Mysql 8 docker container

export CONTAINER_NAME=coconut-db

CHECK_CONTAINER_STATUS=$(docker ps | grep $CONTAINER_NAME)

if [[ -z "$CHECK_CONTAINER_STATUS" ]]; then
  printf "Mysql Docker container is not running\n"
  exit
fi

docker stop $(docker ps -aqf "name=${CONTAINER_NAME}")
