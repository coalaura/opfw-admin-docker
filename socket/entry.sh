#!/bin/sh

set -e

echo "Updating socket..."
cd /usr/src/app
git pull

exec "$@"