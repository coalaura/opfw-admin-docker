#!/bin/sh

set -e

echo "Updating panel..."
cd /var/www/html
git pull

exec "$@"