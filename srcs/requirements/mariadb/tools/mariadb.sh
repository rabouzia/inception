#!/bin/sh

service mysql start

echo "CREATE USER '$BDD_USER'@'%' IDENTIFIED BY '$BDD_USER_PASSWORD';" | mysql

echo "GRANT ALL PRIVILEGES ON *.* TO '$BDD_USER'@'%' IDENTIFIED BY '$BDD_USER_PASSWORD';"  | mysql
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$BDD_ROOT_PASSWORD';"  | mysql
echo "FLUSH PRIVILEGES;" | mysql

echo "CREATE DATABASE $BDD_NAME;" | mysql

kill $(cat /vat/run/mysqld/mysqld.pid)

mysqld
