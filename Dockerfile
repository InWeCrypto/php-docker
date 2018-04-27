FROM php:7.2.5-apache

MAINTAINER support@inwecrypto.com


RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev libpq-dev \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr --with-freetype-dir=/usr \
    && docker-php-ext-install gd pdo_mysql zip opcache pdo pdo_pgsql bcmath

RUN cp /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled

ENV APACHE_DOCUMENT_ROOT /var/www/html/public
