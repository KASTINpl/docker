#!/bin/bash

OPT_UID=`stat -c "%u" /opt`

if [ "$OPT_UID" -gt "0" ]; then
    usermod -u $OPT_UID php >/dev/null 2>&1
    chown php:php -R /home/php
    sudo -u php $@
else
    exec "$@"
fi
