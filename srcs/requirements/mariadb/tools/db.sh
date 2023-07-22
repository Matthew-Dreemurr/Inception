#!/bin/bash

create_db() {

	echo "--==== Install database ====--";
	# mysql_install_db --rpm 
	echo "db installed";
	# mysqld_safe &
	service mariadb start;
	echo "--==== Create database ====--";

	echo "Remove demo database"
	mysql -u root -e "DROP DATABASE IF EXISTS test" 
	echo "Create database ${SQL_DATABASE}"
	mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE} DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;;"

	echo "--==== Create user ====--";

	echo "Create ${SQL_USER}";
	mysql -u root -e "CREATE USER IF NOT EXISTS '${SQL_USER}'@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
	echo "Grant all privileges to ${SQL_USER}";
	mysql -u root -e "GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
	echo "Flush privileges";
	mysql -u root -e "FLUSH PRIVILEGES;"
	echo "Show privileges of ${SQL_USER}";
	mysql -u root -e "SHOW GRANTS FOR '${SQL_USER}';"

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
		echo "Shutdown OK";
		#exec mysqld_safe
	fi
}


echo "-----====#### Starting mariadb script  ####====-----"

DIR=/data

# if [[ -d "$DIR/mysql" ]];
# then
# 	echo "$DIR/mysql exists."
# 	echo "Skip db setup"
# else
# 	echo "$DIR dont exists."

	mkdir -p $DIR/mysql

	chown mysql:mysql -R /$DIR

	echo "Create db"
	create_db;
# fi

echo "Start mariadb server"
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/mysql/mariadb.conf.d/50-server.cnf
# sed -i "s|.*datadir\s*=.*|datadir=/data|g" /etc/mysql/mariadb.conf.d/50-server.cnf
exec mysqld_safe;

#exit 0
