#!/bin/sh

set -e
cd /usr/src/app

echo "Updating socket..."
git pull

exec "$@"