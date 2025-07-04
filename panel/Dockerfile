FROM php:8.2-cli as builder

RUN apt-get update && apt-get install -y git unzip zip libzip-dev libpng-dev libjpeg-dev libfreetype6-dev libgmp-dev
RUN apt-get install -y --no-install-recommends imagemagick libmagickwand-dev
RUN rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j$(nproc) gd zip pdo_mysql gmp
RUN pecl install imagick && docker-php-ext-enable imagick
RUN curl -fsSL https://bun.sh/install | bash
RUN mv /root/.bun/bin/bun /usr/local/bin/

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /app

RUN git clone --depth 1 --branch master https://github.com/coalaura/opfw-admin.git .
RUN composer install --no-dev --optimize-autoloader
RUN bun install --frozen-lockfile
RUN bun run build

FROM php:8.2-fpm

COPY --from=builder /usr/local/etc/php/conf.d/ /usr/local/etc/php/conf.d/
COPY --from=builder /usr/local/lib/php/extensions/ /usr/local/lib/php/extensions/

RUN apt-get update && apt-get install -y libgmp10 libmagickwand-6.q16-6 && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

COPY --from=builder /app .

RUN chown -R www-data:www-data /var/www/html

CMD ["php-fpm"]