#!/bin/sh
set -eu

/usr/local/bin/python /app/get_key.py >> /var/log/cron.log 2>&1
exec crond -f
