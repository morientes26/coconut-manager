#!/usr/bin/env bash

# Running Mysql 8 docker container

export MYSQL_ROOT_PASSWORD=coconut
export DB_STORE_NAME_PATH=db-data
export CONTAINER_NAME=coconut-db

if [ -x "$(command -v docker)" ]; then
    printf "Running on $(docker --version)\n"
else
    printf "\nScript has been terminated !\n"
    printf "Please install docker [ https://docs.docker.com/engine/install ]"
fi

SCRIPT_PATH=$(cd "$(dirname "$0")" && pwd)
ROOT_PATH=$(echo $SCRIPT_PATH | sed -e "s/bin//g")
DB_STORE_PATH="${ROOT_PATH}${DB_STORE_NAME_PATH}"
INIT_DB=0

if [ ! -d "$DB_STORE_PATH" ]; then
  echo "Creating path for storing database files from container ${DB_STORE_PATH}"
  mkdir ${DB_STORE_PATH}
  INIT_DB=1
fi

CHECK_CONTAINER_STATUS=$(docker ps | grep $CONTAINER_NAME)

if [[ ! -z "$CHECK_CONTAINER_STATUS" ]]; then
  printf "Docker container is already running\n"
else
  printf "Starting docker container...\n"
  docker run \
    -e "MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}" \
    --rm -d -p 3306:3306 \
    -v $DB_STORE_PATH:/var/lib/mysql \
    -v $ROOT_PATH/docker/db/init:/docker-entrypoint-initdb.d \
    --name $CONTAINER_NAME -t mysql:8

  if [[ "$INIT_DB" == 1 ]]; then
      printf "Seeding database... (it will took more than minute)\n"
      sleep 45
      docker exec -i $CONTAINER_NAME sh -c 'exec mysql coconu24_dev -uroot -p"$MYSQL_ROOT_PASSWORD"' < $ROOT_PATH/docker/db/seed/database.sql
      docker exec -i $CONTAINER_NAME sh -c 'exec mysql coconu24_testing -uroot -p"$MYSQL_ROOT_PASSWORD"' < $ROOT_PATH/docker/db/seed/database.sql
  fi
fi
