#!/bin/sh

echo "[INFO] Create wordpress config"
# TODO check if the config exist https://developer.wordpress.org/cli/commands/config/path/
# Skip if true
wp config create --dbname=$SQL_DATABASE --dbuser=$SQL_USER --dbpass=$SQL_PASSWORD --dbhost=$SQL_HOST

echo "[INFO] Check db connection"
wp db check

if [ $? -eq 0 ]; then
	echo "[INFO] db connected"
else
	echo "[ERROR] db connection faild!"
	exit 1;
fi

echo "[INFO] Install and create admin user"
wp core install --url=$WP_URL --title="$WP_TITLE" --admin_user=$WP_ADMIN_NAME --admin_password=$WP_ADMIN_PASSWD --admin_email=$WP_ADMIN_EMAIL

if [ $? -eq 0 ]; then
	echo "[INFO] WP install successful"
else
	echo "[ERROR] WP install faild!"
	exit 1;
fi

echo "[INFO] Create $WP_USER_NAME user"
wp user create $WP_USER_NAME $WP_USER_EMAIL --user_pass=$WP_USER_PASSWD --display_name=$WP_USER_DISPLAY_NAME 

if [ $? -eq 0 ]; then
	echo "[INFO] $WP_USER_NAME created"
else
	echo "[ERROR] Faild to create $WP_USER_NAME!"
	exit 1;
fi

echo "[INFO] Starting php-fpm"

php-fpm -F