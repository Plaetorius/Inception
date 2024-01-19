#!/bin/bash
# while ! mysqladmin ping --silent; do
#     echo "Waiting for MariaDB to start..."
#     sleep 2
# done
 sleep 10

echo -e "\e[1m================ START =================\e[0m"

echo -e "\e[1m============= ENTERING DIR =============\e[0m"
cd /var/www/html/wordpress

echo -e "\e[1m=========== TESTING ENV VARS ===========\e[0m" 
echo SQL_DATABASE=${SQL_DATABASE} SQL_USER=${SQL_USER}

grep "/run/mysqld/mysqld.sock" /etc/php/7.4/fpm/php.ini

echo -e "\e[1m============== PINGING DB ==============\e[0m"
echo ${SQL_HOST}

echo -e "\e[1mMariaDB is \e[38;5;34mready\e[0m."

echo -e "\e[1m========= CHECKING FOR WP CORE =========\e[0m"

if ! wp core is-installed --allow-root; then
echo -e "\e[1m============ CONFIG CREATE =============\e[0m"
	wp config create --allow-root --dbname=${SQL_DATABASE} \
		--dbuser=${SQL_USER} \
		--dbpass=${SQL_PASSWORD} \
		--dbhost=${SQL_HOST} \
		--url=https://${DOMAIN_NAME}
chown -R www-data:www-data wp-config.php
chmod -R 755 wp-config.php
ls -la

echo -e "\e[1m============= CORE INSTALL =============\e[0m"
	wp core install --allow-root \
		--url=https://${DOMAIN_NAME} \
		--title=${SITE_TITLE} \
		--admin_user=${ADMIN_USER} \
		--admin_password=${ADMIN_PASSWORD} \
		--admin_email=${ADMIN_EMAIL}

echo -e "\e[1m============= USER CREATE ==============\e[0m"
	wp user create --allow-root \
		${USER1_LOGIN} ${USER1_EMAIL} \
		--role=author \
		--user_pass=${USER1_PASSWORD}

echo -e "\e[1m============= CACHE FLUSH ==============\e[0m"
	wp cache flush --allow-root

echo -e "\e[1m========= INSTALL CONTACT-FORM =========\e[0m"
	wp plugin install contact-form-7 --allow-root --activate

echo -e "\e[1m============ SETUP LANGUAGE ============\e[0m"
	wp language core install en_US --allow-root --activate

echo -e "\e[1m======== DELETE USELESS PLUGINS ========\e[0m"
	wp theme delete twentytwenty twentynineteen --allow-root
	wp plugin delete hello --allow-root

fi

echo -e "\e[1m======== CHECKING FOR /run/php/ ========\e[0m"
if [ ! -d /run/php ]; then
	mkdir /run/php
	echo -e "\e[1mDir '/run/php/' created \e[38;5;34msuccesfully\e[0m."
fi

echo -e "\e[1m=========== SETTING UP PERMS =============\e[0m"
chown -R www-data:www-data /var/www/html/wordpress/wp-includes
chown -R www-data:www-data /var/www/html/wordpress/wp-content
chown -R www-data:www-data /var/www/html/wordpress/wp-admin

echo -e "\e[1m=========== MODIFY UPLOAD SIZE =============\e[0m"
FILES="/etc/php/7.4/cli/php.ini /etc/php/7.4/fpm/php.ini"

for FILE in $FILES; do
    if [[ -f $FILE ]]; then
        sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 16M/g' "$FILE"
        echo "Modified $FILE"
    else
        echo "File $FILE does not exist"
    fi
done

mkdir -p /var/www/html/wordpress/static
cp	/etc/static/* /var/www/html/wordpress/static/
chown -R www-data:www-data /var/www/html/wordpress/static/
chmod 755 /var/www/html/wordpress/static/*

echo -e "\e[38;5;34m############### FINISHED ###############\e[0m"

echo -e "\e[1m=============== EXEC PHP ==============\e[0m"
exec /usr/sbin/php-fpm7.4 -F -R
