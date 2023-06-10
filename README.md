# PHP8 for production

## Description

I have prepared a light and tested php8 alpine3.18 for use in your PHP project that is ready to use


## How to use

```
  php:
    image: k90mirzaei/php:8.2-fpm-alpine3.18
    container_name: php
    env_file: .env
    volumes:
      - ./laravel:/var/www
      - .docker/php/php.ini:/usr/local/etc/php/conf.d/local.ini
      - .docker/php/entrypoint.sh:/tmp/entrypoint.sh
    networks:
      app-network:
```
