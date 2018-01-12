FROM webdevops/base-app:alpine

MAINTAINER support@inwecrypto.com

ENV WEB_DOCUMENT_ROOT=/app \
    WEB_DOCUMENT_INDEX=index.php \
    WEB_ALIAS_DOMAIN=*.vm \
    WEB_PHP_TIMEOUT=600 \
    WEB_PHP_SOCKET=""

ENV WEB_PHP_SOCKET=127.0.0.1:9000

RUN set -x \
    && apk-install \
    nginx \
    # Install php environment
    && apk-install \
    # Install tools
    imagemagick \
    graphicsmagick \
    ghostscript \
    # Install php (cli/fpm)
    php7-fpm \
    php7-json \
    php7-intl \
    php7-curl \
    #php7-mysqli \
    #php7-mysqlnd \
    php7-pdo \
    php7-pdo_pgsql \
    php7-pdo_sqlite \
    php7-mcrypt \
    php7-gd \
    php7-bcmath \
    php7-soap \
    # php7-sqlite3 \
    php7-bz2 \
    php7-calendar \
    php7-ctype \
    #php7-pcntl \
    #php7-posix \
    php7-sockets \
    php7-sysvmsg \
    php7-sysvsem \
    php7-sysvshm \
    php7-xmlreader \
    php7-exif \
    #php7-ftp \
    php7-gettext \
    php7-iconv \
    php7-zip \
    php7-zlib \
    php7-shmop \
    php7-wddx \
    #sqlite \
    php7-xmlrpc \
    php7-xsl \
    geoip \
    php7-ldap \
    # php7-memcache \
    php7-redis \
    php7-pear \
    php7-phar \
    php7-openssl \
    php7-session \
    php7-opcache \
    php7-mbstring \
    php7-iconv \
    php7-apcu \
    php7-fileinfo \
    php7-simplexml \
    php7-tokenizer \
    php7-xmlwriter \
    && ln -s /usr/sbin/php-fpm7 /usr/sbin/php-fpm \
    && pear channel-update pear.php.net \
    && pear upgrade-all \
    && pear config-set auto_discover 1 \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer \
    # PECL workaround, see webdevops/Dockerfile#78
    && sed -i "s/ -n / /" $(which pecl) \
    # Enable php services
    && docker-service enable syslog \
    && docker-service enable cron \
    && docker-run-bootstrap \
    && docker-image-cleanup


COPY conf/ /opt/docker/

EXPOSE 9000
EXPOSE 80 443