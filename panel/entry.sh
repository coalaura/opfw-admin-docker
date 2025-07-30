#!/bin/sh

set -e
cd /var/www/html

OLD_HEAD=$(git rev-parse HEAD)

echo "Updating panel..."
git pull

if [ "$OLD_HEAD" != "$(git rev-parse HEAD)" ]; then
	echo Rebuilding frontend...
	bun run prod
fi

echo "Migrating panel..."
php artisan migrate

exec "$@"