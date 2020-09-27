FROM php:7.2-fpm-alpine

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apk add --no-cache git curl bash supervisor nginx gettext-dev autoconf libxml2-dev libzip-dev zlib-dev libpng-dev g++ make gcompat \
    && rm -rf /var/cache/apk/*

RUN docker-php-ext-install mysqli bcmath exif gettext zip gd pdo pdo_mysql soap \
    && docker-php-ext-enable pdo_mysql

RUN mkdir -p /run/nginx
RUN mkdir -p /run/php
RUN mkdir -p /etc/supervisor.d

COPY docker/nginx.conf /etc/nginx/nginx.conf
COPY docker/php.ini /usr/local/etc/php/php.ini
COPY docker/virgil_crypto_php.so /usr/local/lib/php/extensions/no-debug-non-zts-20170718/virgil_crypto_php.so
COPY docker/supervisord.conf /etc/supervisord.conf
COPY docker/startup.sh /usr/local/bin/startup.sh

# Copy app files and set permissions
#RUN mkdir -p /app
#COPY . /app
#RUN chown -R www-data: /app

EXPOSE 80

CMD bash /usr/local/bin/startup.sh
