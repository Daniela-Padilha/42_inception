#!/bin/bash

service mariadb start

# put in .env at the end
DB_NAME=db
DB_USER=ddo-carm
DB_PASSWORD=123
DB_PASS_ROOT=abc

mariadb -v -u root << EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_PASS_ROOT';
FLUSH PRIVILEGES;
EOF

sleep 5
service mariadb stop

exec $@