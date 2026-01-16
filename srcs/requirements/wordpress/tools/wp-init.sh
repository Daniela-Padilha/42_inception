#!/bin/bash
set -e

#wait for db
echo "Waiting for MariaDB..."
until mysql -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" &>/dev/null
do
    sleep 2
done
echo "Database ready!"

cd /var/www/html

# Download WordPress if necessary
if [ ! -f wp-config.php ]; then
    echo "Downloading WordPress..."
    curl -O https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz
    mv wordpress/* .
    rm -rf wordpress latest.tar.gz

    echo "Configuring WordPress..."
    cp wp-config-sample.php wp-config.php

	#edit conf file
    sed -i "s/database_name_here/$DB_NAME/" wp-config.php
    sed -i "s/username_here/$DB_USER/" wp-config.php
    sed -i "s/password_here/$DB_PASSWORD/" wp-config.php
    sed -i "s/localhost/$DB_HOST/" wp-config.php
fi

#permissions
chown -R www-data:www-data /var/www/html

exec php-fpm8.2 -F
