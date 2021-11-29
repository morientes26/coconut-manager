# Manager Application

[![Coverage Status](https://coveralls.io/repos/github/slimphp/Slim-Skeleton/badge.svg?branch=master)](https://coveralls.io/github/slimphp/Slim-Skeleton?branch=master)

The skeleton of the application is working on a new Slim Framework 4 with Slim PSR-7 implementation and PHP-DI container implementation. It also uses the Monolog logger.

This skeleton application was built for Composer. This makes setting up a new Slim Framework application quick and easy.

## Install the Application

- Ensure `logs/` is web writable.
- Install dependences

```bash
composer install
```

## Database

Configuration of database is made by environment variables defined in the file `.env` in the root of the application.

For local development can be use running Mysql Docker Container or use external database. Next command will start, init and seed Mysql database.

## Start Mysql database as a container

```bash
./bin/start_db.sh
```

## Stop Mysql container

```bash
./bin/stop_db.sh
```

## Running application

```bash
composer start
```

After that, open `http://localhost:8080` in your browser.

Run this command in the application directory to run the test suite

```bash
composer test
```

## Simulate production environment

You can use `docker-compose` to run all ecosystem (app, database, nginx) with `docker`, so you can run these commands:

```bash
docker-compose up -d
```

Stop apps ecosystem

```bash
docker-compose down
```
