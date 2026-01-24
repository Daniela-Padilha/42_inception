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
if [ ! -f wp-cli.phar ]; then
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
fi

# config users
WP="./wp-cli.phar"

if [ ! -f wp-config-sample.php ]; then
	$WP core download --allow-root
fi

if [ ! -f wp-config.php ]; then
	$WP config create \
		--dbname="$DB_NAME" \
		--dbuser="$DB_USER" \
		--dbpass="$DB_PASSWORD" \
		--dbhost="$DB_HOST" \
		--allow-root
fi

if ! $WP core is-installed --allow-root >/dev/null 2>&1; then
       $WP core install \
	       --url="$WP_DOMAIN" \
	       --title="$WP_TITLE" \
	       --admin_user="$WP_ADMIN_USER" \
	       --admin_password="$WP_ADMIN_PASSWORD" \
	       --admin_email="$WP_ADMIN_EMAIL" \
	       --allow-root
fi

if ! $WP user get "$WP_GUEST_USER" --allow-root >/dev/null 2>&1; then
       $WP user create "$WP_GUEST_USER" "$WP_GUEST_EMAIL" \
	       --role=subscriber\
	       --user_pass="$WP_GUEST_PASSWORD" \
	       --allow-root
fi

#permissions
chown -R www-data:www-data /var/www/html

exec php-fpm8.2 -F
