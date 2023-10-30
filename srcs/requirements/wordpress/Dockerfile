FROM debian:bullseye

# Install tools 
RUN apt-get update && \
	apt-get upgrade && \
    apt-get install -y wget php7.3 php-fpm php-mysql mariadb-client default-mysql-client curl vim sudo && \
    apt-get clean

ENV DOMAIN_NAME=tgernez.42.fr
ENV SITE_TITLE=MyWebsiet
ENV ADMIN_USER=god

ENV MYSQL_DATABASE=db_inception
ENV MYSQL_USER=db_user
ENV MYSQL_PASSWORD=db_password
ENV MYSQL_ROOT_PASSWORD=db_root_password

# Install Wordpress
RUN wget https://fr.wordpress.org/wordpress-6.3.2-fr_FR.tar.gz -P /var/www && \
    cd /var/www && \
    tar -xzf wordpress-6.3.2-fr_FR.tar.gz && \
    rm wordpress-6.3.2-fr_FR.tar.gz && \
    chown -R root:root /var/www/wordpress

# Install Wordpress CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

RUN echo "clear_env = 0" >> /etc/php/7.4/fpm/php-fpm.conf && \
    echo "listen = wordpress:9000" >> /etc/php/7.4/fpm/php-fpm.conf

RUN mkdir -p /etc/tools && \
    chmod -R 755 /etc/tools

RUN chown -R www-data:www-data /var/www/* && \
    chmod -R 755 /var/www/

EXPOSE 9000

COPY ./tools/init-wp.sh /etc/tools

# CMD [ "bash", "tools/init-wp.sh"]