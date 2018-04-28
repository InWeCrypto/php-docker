FROM daocloud.io/inwecrypto/nginx-php-fpm:master-0e023f4

LABEL MAINTAINER support@inwecrypto.com

COPY conf/nginx-site.conf /etc/nginx/sites-available/default.conf

RUN set -ex \
    && apk del openssl-dev \
    && apk --no-cache add postgresql-dev

RUN docker-php-ext-configure gd \
    && docker-php-ext-install gd zip opcache pdo pdo_pgsql bcmath

ENV WEBROOT /var/www/html/public