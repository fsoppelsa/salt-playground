#!/bin/bash
set -e
minions=$1

/usr/bin/salt-master -d --log-file=/var/log/salt/master --log-file-level=debug
until [ `salt-key -F | grep -A100 ^Unaccepted | grep -v ^Unaccepted | wc -l` = $minions ] ; do sleep 10; done
/usr/bin/salt-key -Ay > /dev/null 2>&1
while (true); do sleep 3600; done

exec "$@"
