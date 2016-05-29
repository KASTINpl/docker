#!/bin/bash

OPT_UID=`stat -c "%u" /opt`

echo "$@"
    
if [ "$OPT_UID" -gt "0" ]; then
    usermod -u $OPT_UID nodejs >/dev/null 2>&1
    chown nodejs:nodejs -R /home/nodejs
    sudo -u nodejs $@
else
    exec "$@"
fi

