# Adminer Docker Image
[![Build Status](https://travis-ci.com/edyan/docker-adminer.svg?branch=master)](https://travis-ci.com/edyan/docker-adminer)
[![Docker Pulls](https://img.shields.io/docker/pulls/edyan/adminer.svg)](https://hub.docker.com/r/edyan/adminer/)


Docker Hub: https://hub.docker.com/r/edyan/adminer

A lightweight Docker container (~ 10MB!) with an embedded version 
of [Adminer](https://www.adminer.org) (PHP7 on Alpine).

For now, only the following PHP extensions have been installed : 
_DBLib (SQLServer), MySQL, PostgreSQL, SQLite_, _MongoDB_ and _ODBC_.

## Environment variable
You can set adminer's version by using **ADMINER_VERSION**.

## Case of password less databases (SQLite)
Enter the "default" password is _password_ to let adminer login.

## Usage
Add the following to your docker-compose.yml file:
```yaml
adminer:
    image: edyan/adminer
    environment:
        ADMINER_VERSION: 4.6.2
```

## Changing theme
If you want to change the theme, override the file `/app/adminer.css` by mounting a volume.
