#!/bin/bash

cat << EOF > /etc/mysql/init.sql
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
FLUSH PRIVILEGES;
EOF

mkdir -p /var/lib/mysql

mariadb-install-db --ldata=/var/lib/mysql

exec mysqld --init-file=/etc/mysql/init.sql
