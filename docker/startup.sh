#!/usr/bin/env bash

# Run Migrations on container instantiation
php /app/public/index.php Migrate latest

/usr/bin/supervisord -c /etc/supervisord.conf
