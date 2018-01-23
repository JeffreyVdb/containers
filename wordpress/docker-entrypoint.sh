#!/bin/sh
set -o errexit

DAEMON_USER=www-data
if [ $(id -u) -eq 0 ]; then
    echo "Changing user to $DAEMON_USER"
    su-exec "$DAEMON_USER" test -w "$APP_ROOT" || chown -R -- "$DAEMON_USER" "$APP_ROOT"
    exec su-exec "$DAEMOM_USER" "$0" "$@"
fi

exec "$@"