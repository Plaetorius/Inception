FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    wget \
    unzip \
    php-fpm \
    php-mysqli \
    php-xml \
    php-gd \
    php-curl \
    php-zip \
    php-mbstring

WORKDIR /var/www/html
RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xvzf latest.tar.gz && \
    mv wordpress/* . && \
    rmdir wordpress && \
    rm latest.tar.gz

COPY ./www.conf /etc/php/7.4/fpm/pool.d/www.conf
RUN chown -R www-data:www-data /var/www/html
RUN mkdir -p /run/php/

EXPOSE 9000

CMD ["php-fpm7.4", "-F"]
