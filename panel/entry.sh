#!/bin/sh

set -e
cd /var/www/html

echo "Starting cron..."
cron

OLD_HEAD=$(git rev-parse HEAD)

echo "Updating panel..."
git pull

if [ "$OLD_HEAD" != "$(git rev-parse HEAD)" ]; then
	echo Rebuilding frontend...
	bun run prod
fi

echo "Clearing cache..."
rm -rf storage/framework/cache/data/*

echo "Migrating panel..."
php artisan migrate

echo "Running initial cronjobs..."
bash docker-cron.sh

exec "$@"