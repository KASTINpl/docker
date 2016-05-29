#!/bin/bash

OPT_UID=`stat -c "%u" /opt`

if [ "$OPT_UID" -gt "0" ]; then
    usermod -u $OPT_UID www-data >/dev/null 2>&1
fi

exec "$@"