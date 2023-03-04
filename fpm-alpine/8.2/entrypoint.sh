#!/bin/sh

# Sample setup steps in laravel
composer install -q --no-ansi --no-interaction --no-scripts --no-progress --prefer-dist
php artisan optimize:clear
php artisan key:generate --force
php artisan migrate --force --seed
php artisan up