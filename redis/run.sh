#!/bin/sh

docker run --name docker-redis \
 -p 6379:6379 \
 --restart=always \
 -v ~/docker-volumes/redis/data:/data \
 -d redis \
 --requirepass "123456" 