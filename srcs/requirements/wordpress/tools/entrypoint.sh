#!/bin/sh

if [ ! -f "/var/www/html/wp-config.php" ]; then

  chown -R www-data:www-data /var/www/html/
  cd /var/www/html

  wp core download --allow-root

  until mysqladmin --user=${MYSQL_USER} --password=${MYSQL_PASSWORD} --host=mariadb ping; do
    sleep 2
  done

  USERID=${USER:-keandria}
  wp config create --dbname=${MYSQL_DATABASE} \
    --dbuser=${MYSQL_USER} \
    --dbpass=${MYSQL_PASSWORD} \
    --dbhost=mariadb \
    --allow-root

  wp core install --url=${USERID}.42.fr \
    --title=${WP_TITLE} \
    --admin_user=${WP_ADMIN} \
    --admin_password=${WP_ADMIN_PASSWORD} \
    --admin_email=${WP_ADMIN_EMAIL} \
    --skip-email \
    --allow-root

  wp user create ${WP_USER} ${WP_USER_EMAIL} \
    --user_pass=${WP_USER_PASSWORD} \
    --role=author \
    --allow-root

  #wp theme install upright write blogasm generatepress
  #wp theme list --status=inactive
  #wp theme activate upright

  wp theme install "generatepress" --activate --allow-root

  wp post generate \
    --count=1 \
    --post_author="${WP_USER}" \
    --post_title="My fisrt post!" \
    --post_content="This is my first post" \
    --allow-root

  wp post create \
    --post_author="${WP_ADMIN}" \
    --post_title="Pygmalion: The Myth of Creation and Love" \
    --post_content="Pygmalion is a famous figure from Greek mythology, known as a sculptor who fell in love with a statue he created. According to the myth, his desire and devotion brought the statue to life. The story explores themes of creation, love, beauty, and the relationship between an artist and their creation." \
    --post_status=publish \
    --allow-root

fi

exec "$@"
