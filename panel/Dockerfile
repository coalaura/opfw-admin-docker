FROM php:8.2-cli AS builder

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

RUN cp envs/example.root-config.json envs/root-config.json

FROM php:8.2-fpm

COPY --from=builder /usr/local/etc/php/conf.d/ /usr/local/etc/php/conf.d/
COPY --from=builder /usr/local/lib/php/extensions/ /usr/local/lib/php/extensions/
COPY --from=builder /usr/local/bin/bun /usr/local/bin/bun

RUN apt-get update && apt-get install -y --no-install-recommends git cron libgmp10 libmagickwand-6.q16-6 libzip4 && rm -rf /var/lib/apt/lists/*

COPY cron /etc/cron.d/opfw-cron
RUN chmod 0644 /etc/cron.d/opfw-cron

WORKDIR /var/www/html

COPY --from=builder --chown=www-data:www-data /app .

RUN git config --global --add safe.directory /var/www/html

COPY entry.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entry.sh

ENTRYPOINT ["entry.sh"]

CMD ["php-fpm"]