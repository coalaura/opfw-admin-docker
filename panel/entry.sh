#!/bin/bash

set -e
cd /var/www/html

echo "Starting supercronic..."
supercronic -json /etc/cron/app.crontab &

OLD_HEAD=$(git rev-parse HEAD)

echo "Updating panel..."
git pull

if [ "$OLD_HEAD" != "$(git rev-parse HEAD)" ]; then
	echo Rebuilding frontend...
	bun run prod
fi

echo "Clearing cache..."
rm -rf storage/framework/cache/data/*

echo "Running initial cronjobs..."
php artisan cron

exec "$@"
