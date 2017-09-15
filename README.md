[![Layers](https://images.microbadger.com/badges/image/edyan/adminer.svg)](https://microbadger.com/images/edyan/adminer "Get your own image badge on microbadger.com")
[![Docker Pulls](https://img.shields.io/docker/pulls/edyan/adminer.svg)](https://hub.docker.com/r/edyan/adminer/)

# Adminer Docker Image
Docker Hub: https://hub.docker.com/r/edyan/adminer

A lightweight Docker container with an embedded version of [Adminer](https://www.adminer.org) (PHP5 on Alpine).

For now, only the following PHP extensions have been installed : _MySQL, PostgreSQL, SQLite_ and _MS SQL_.

## Usage
Add the following to your docker-compose.yml file:
```yaml
php:
    image: edyan/adminer
    environment:
        ADMINER_VERSION: 4.3.1
    links:
        - mysql
```

## Environment variable
You can set adminer's version by using **ADMINER_VERSION**.
