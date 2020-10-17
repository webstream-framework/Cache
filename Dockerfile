FROM php:7.4-cli
LABEL maintainer Ryuichi Tanaka <mapserver2007@gmail.com>

RUN apt-get update && apt-get install -y \
  git \
  zip \
  zlib1g-dev \
  libpq-dev \
  libmemcached-dev \
  redis-server

RUN pecl install memcached-3.1.5 && \
  pecl install redis-5.3.1 && \
  pecl install xdebug-2.9.8 && \
  pecl install apcu && \
  echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini && \
  echo "xdebug.reemote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini && \
  echo "opcache.enable_cli=1" > /usr/local/etc/php/conf.d/opcache-recommended.ini && \
  echo "apc.enable_cli=1" >> /usr/local/etc/php/conf.d/docker-php-ext-apcu.ini && \
  docker-php-ext-install pdo pdo_mysql pdo_pgsql && \
  docker-php-ext-enable xdebug apcu opcache memcached redis

RUN rm -rf /var/lib/apt/lists/* && rm -rf /tmp/pear && rm -rf php-memcached && rm -rf phpredis && rm -rf /tmp/* && \
  apt-get clean -y && apt-get autoclean -y

WORKDIR /workspace
