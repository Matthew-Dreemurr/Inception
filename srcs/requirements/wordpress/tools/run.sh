#!/bin/sh

echo "[INFO] Create wordpress config"

echo "[INFO] connecting to db"
wp config create --dbname=$SQL_DATABASE --dbuser=$SQL_USER --dbpass=$SQL_PASSWORD --dbhost=$SQL_HOST

echo "[INFO] Check db connection"
wp db check

if [ $? -eq 0 ]; then
	echo "[INFO] db connected"
else
	echo "[ERROR] db connection faild!"
	exit 1;
fi

# echo "[INFO] Create admin user"

echo "[INFO] Starting php-fpm"

php-fpm -F