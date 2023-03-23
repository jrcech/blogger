#!/bin/sh

set -e

cp -r /public /app

manifest_files=/app/public/assets/.sprockets-manifest-*.json

if compgen -G "${manifest_files}" > /dev/null 2>&1; then

  find \
    ${manifest_files} \
    -type f ! -name "$(basename /public/assets/.sprockets-manifest-*.json)" \
    -delete
fi

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

exec "$@"
