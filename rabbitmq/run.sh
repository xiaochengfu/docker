#!/bin/sh

docker run -v ~/docker-volumes/rabbitmq:/var/lib/rabbitmq \
 -p 5672:5672 \
 -p 15672:15672 \
 -e RABBITMQ_DEFAULT_VHOST=/ \
 -e RABBITMQ_DEFAULT_USER=admin \
 -e RABBITMQ_DEFAULT_PASS=123456 \
 --hostname myRabbit \
 --restart=always \
 --name docker-rabbitmq \
 -itd rabbitmq:3.7.7-management