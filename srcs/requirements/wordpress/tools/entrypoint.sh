#!/bin/sh

set -e

if [ ! -f "/var/www/html/wp-config.php" ]; then

  echo "Waiting for MariaDB..."

  until mysqladmin \
    --user="${MYSQL_USER}" \
    --password="${MYSQL_PASSWORD}" \
    --host=mariadb \
    ping --silent; do
    sleep 2
  done

  echo "MariaDB is ready."

  chown -R www-data:www-data /var/www/html/
  cd /var/www/html

  USERID="${USER:-keandria}"

  wp config create \
    --dbname="${MYSQL_DATABASE}" \
    --dbuser="${MYSQL_USER}" \
    --dbpass="${MYSQL_PASSWORD}" \
    --dbhost=mariadb \
    --allow-root

  wp core install \
    --url="${USERID}.42.fr" \
    --title="${WP_TITLE}" \
    --admin_user="${WP_ADMIN}" \
    --admin_password="${WP_ADMIN_PASSWORD}" \
    --admin_email="${WP_ADMIN_EMAIL}" \
    --skip-email \
    --allow-root

  wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
    --user_pass="${WP_USER_PASSWORD}" \
    --role=author \
    --allow-root

  wp theme install arbutus \
    --activate \
    --allow-root

  wp post generate \
    --count=1 \
    --post_author="${WP_USER}" \
    --post_title="42 is the answer!" \
    --allow-root

fi

exec "$@"
