FROM composer:1.9.3 as vendor

RUN docker-php-ext-install mysqli pdo pdo_mysql

WORKDIR /tmp/

COPY . /tmp/
COPY composer.json composer.json
COPY composer.lock composer.lock

RUN composer install \
    --ignore-platform-reqs \
    --no-interaction \
    --no-plugins \
    --no-scripts \
    --prefer-dist

CMD ["composer", "start"]

EXPOSE 9000
