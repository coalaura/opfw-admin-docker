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

FROM php:8.2-fpm

COPY --from=builder /usr/local/etc/php/conf.d/ /usr/local/etc/php/conf.d/
COPY --from=builder /usr/local/lib/php/extensions/ /usr/local/lib/php/extensions/
COPY --from=builder /usr/local/bin/bun /usr/local/bin/bun

RUN apt-get update && apt-get install -y --no-install-recommends git libgmp10 imagemagick libmagickwand-7.q16-10 libzip5 procps && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL -o /usr/local/bin/supercronic https://github.com/aptible/supercronic/releases/download/v0.2.34/supercronic-linux-amd64 && chmod +x /usr/local/bin/supercronic

RUN mkdir -p /etc/cron && printf "SHELL=/bin/sh\nPATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin\n0 0 * * * /usr/local/bin/php /var/www/html/artisan cron\n" > /etc/cron/app.crontab

WORKDIR /var/www/html

COPY --from=builder --chown=www-data:www-data /app .

RUN git config --global --add safe.directory /var/www/html

COPY entry.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entry.sh

ENTRYPOINT ["entry.sh"]

CMD ["php-fpm"]