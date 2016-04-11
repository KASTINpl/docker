#!/bin/bash
set -e

OPT_UID=`stat -c "%u" /opt`;

if (( $OPT_UID > 0 )); then
    usermod -u $OPT_UID www-data;
fi

exec "$@"