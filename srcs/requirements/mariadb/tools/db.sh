#!/bin/bash

service mariadb start;

echo "--==== Create database ====--";

echo "Remove demo database"
mysql -e "DROP DATABASE IF EXISTS test"
echo "Create database ${SQL_DATABASE}"
mysql -e "CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE} DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;;"

echo "--==== Create user ====--";

echo "Create ${SQL_USER}";
mysql -e "CREATE USER IF NOT EXISTS '${SQL_USER}'@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
echo "Grant all privileges to ${SQL_USER}";
mysql -e "GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
echo "Flush privileges";
mysql -e "FLUSH PRIVILEGES;"
echo "Show privileges of ${SQL_USER}";
mysql -e "SHOW GRANTS FOR '${SQL_USER}';"

# echo "Edit root setting";
# mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

echo "--==== Stop db ====--";
mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown
# service mariadb stop;
if [ $? -ne 0 ];
then
	echo "Shutdown Failed!"
	exit 1;
else
	echo "--==== Start db ====--";
	exec mysqld_safe
fi
dxit 0