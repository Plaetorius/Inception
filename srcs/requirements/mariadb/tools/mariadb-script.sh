#!/bin/bash

# Start MariaDB in the background to perform setup
mysqld_safe &
pid="$!"

# Wait for MariaDB to start
sleep 10

# Use the mysqladmin utility to wait for server to finish starting
while ! mysqladmin ping --silent; do
    echo "Waiting for MariaDB to start..."
    sleep 2
done

# Database and user setup
mysql -uroot <<-EOSQL && echo -e "mariadb queries [\033[32mOK\033[0m]"
    CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
    CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO ${MYSQL_USER}@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    FLUSH PRIVILEGES;
    SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${MYSQL_ROOT_PASSWORD}');
    FLUSH PRIVILEGES;
EOSQL

# Clean stop MariaDB (avoid using tail -f, sleep)
mysqladmin -uroot -p${MYSQL_ROOT_PASSWORD} shutdown

# Wait for MariaDB to finish shutting down
wait "$pid"

# Start MariaDB in the foreground
exec mysqld_safe