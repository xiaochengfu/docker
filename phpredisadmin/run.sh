#!/bin/sh
 
docker run --name docker-phpredisadmin \
 -p 9002:80 \
 -e REDIS_1_HOST=127.0.0.1 \
 -e REDIS_1_AUTH=123456 \
 --restart=always \
 -itd erikdubbelboer/phpredisadmin 