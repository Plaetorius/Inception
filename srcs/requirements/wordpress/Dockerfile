FROM debian:bullseye

# Install tools 
RUN apt-get update && \
	apt-get upgrade && \
    apt-get install -y wget php php-fpm php-mysql mariadb-client default-mysql-client curl vim sudo && \
    apt-get clean

# Install Wordpress
RUN wget https://fr.wordpress.org/wordpress-6.3.2-fr_FR.tar.gz -P /var/www/html/ && \
    cd /var/www/html/ && \
    tar -xzf wordpress-6.3.2-fr_FR.tar.gz && \
    rm wordpress-6.3.2-fr_FR.tar.gz && \
    chown -R root:root /var/www/html/wordpress

# Install Wordpress CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

RUN echo "clear_env=no" >> /etc/php/7.4/fpm/php.ini && \
    echo "listen=wordpress:9000" >> /etc/php/7.4/fpm/php.ini

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir -p /etc/tools && \
    chmod -R 755 /etc/tools

RUN mkdir -p /etc/static && \
    chmod -R 755 /etc/static

COPY ./tools/init-wp.sh /etc/tools/
COPY ./static/* /etc/static/

RUN chown -R www-data:www-data /var/www/* && \
    chmod -R 755 /var/www/*

EXPOSE 9000

CMD [ "bash", "/etc/tools/init-wp.sh"]