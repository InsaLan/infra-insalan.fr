#!/bin/sh

./nginxhotreload.sh &

# default nginx entrypoint
exec /docker-entrypoint.sh "$@"
