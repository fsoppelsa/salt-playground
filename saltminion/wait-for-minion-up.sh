#!/bin/bash

set -e
cmd="$@"

until salt-minion; do
  >&2 echo "Minion not up yet - sleeping"
  sleep 5
done

>&2 echo "Minion is up"
exec $cmd
