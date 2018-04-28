FROM richarvey/nginx-php-fpm:1.5.0

LABEL MAINTAINER support@inwecrypto.com

RUN set -ex \
    && apk del openssl-dev \
    && apk --no-cache add postgresql-dev

RUN docker-php-ext-configure gd \
    && docker-php-ext-install gd zip opcache pdo pdo_pgsql bcmath

ENV WEBROOT /var/www/html/public