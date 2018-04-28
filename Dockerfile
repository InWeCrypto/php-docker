FROM richarvey/nginx-php-fpm:1.5.0

LABEL MAINTAINER support@inwecrypto.com

RUN docker-php-ext-configure gd \
    && docker-php-ext-install gd pdo_mysql zip opcache pdo pdo_pgsql bcmath

ENV WEBROOT /var/www/html/public