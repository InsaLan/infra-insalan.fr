#!/bin/bash
###########

while true
do
 inotifywait --exclude .swp -e create -e modify -e delete -e move /etc/nginx/templates
 echo "Detected Nginx Configuration Change"
 echo "Reloading nginx"
 /docker-entrypoint.sh nginx -s reload
done
