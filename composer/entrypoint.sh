#!/bin/bash

OPT_UID=`stat -c "%u" /opt`

if [ "$OPT_UID" -gt "0" ]; then
    usermod -u $OPT_UID php
    chown php:php /home/php
    sudo -u php $@
else
    exec "$@"
fi
