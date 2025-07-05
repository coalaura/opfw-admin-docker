#!/bin/bash

set -e

if ! command -v openssl >/dev/null 2>&1; then
    echo "Error: openssl is not installed. Please install it to continue." >&2

    exit 1
fi

if [ ! -f ".env" ]; then
    cp .example.env .env
fi

replace_value() {
    sed -i "s|^${1}=.*|${1}=${2}|" .env
}

replace_value "DOCKER_INFLUX_PASSWORD" "$(openssl rand -hex 12)"
replace_value "DOCKER_INFLUX_TOKEN" "$(openssl rand -hex 24)"
replace_value "APP_KEY" "\"base64:$(openssl rand -base64 32)\""

echo Done.