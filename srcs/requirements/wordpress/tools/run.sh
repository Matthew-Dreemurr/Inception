#!/bin/sh

echo "Staring php-fpm"

mkdir -p /usr/logs/php-fpm
php-fpm -F