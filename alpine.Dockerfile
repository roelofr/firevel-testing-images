# vim: set ft=dockerfile :
# Configuration file for Docker

# Configuration file for Docker
FROM php:cli-alpine

# Install native extensions
# 1) Install dependencies and dev dependencies
# 2) Install common extensions
# 4) Remove dev dependencies
# 5) Remove compile-time deps
# 6) Delete extracted source and caches
RUN apk update \
    && apk add \
        curl \
        libxml2 \
        libzip \
        oniguruma \
    && apk add \
        --virtual php-deps \
        curl-dev \
        libxml2-dev \
        libzip-dev \
        oniguruma-dev \
    && docker-php-ext-install -j "$(nproc)" \
        bcmath \
        curl \
        dom \
        mbstring \
        zip \
    && apk del php-deps \
    && rm -rf \
        /var/cache/apk/* \
        /var/lib/apk/* \
        /etc/apk/cache/*

# Install pecl extensions
# 1) Install dependencies and dev dependencies
# 2) Build gRPC
# 4) Remove exanded source code
# 5) Remove apk temp dirs and pecl build dir
RUN apk add --no-cache zlib \
    && apk add -U \
        --virtual grpc-deps \
        ${PHPIZE_DEPS} \
        autoconf \
        automake \
        linux-headers \
        zlib-dev \
    && pecl install grpc \
    && docker-php-ext-enable grpc \
    && docker-php-source delete \
    && apk del grpc-deps \
    && rm -rf \
        /tmp/pear \
        /var/cache/apk/* \
        /var/lib/apk/* \
        /etc/apk/cache/*

# Install Git
RUN apk --no-cache add git

# Install latest version of Composer
RUN curl -L -o composer-setup.php -sS https://getcomposer.org/installer \
    && test "$(php -r "echo hash_file('sha384', 'composer-setup.php');")" = "$(curl -qL -o- https://composer.github.io/installer.sig)" \
    && php composer-setup.php -- --install-dir=/usr/local/bin --filename=composer \
    && rm composer-setup.php

RUN mkdir /var/www/testing
WORKDIR /var/www/testing
