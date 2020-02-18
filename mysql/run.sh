#!/bin/sh

docker run -v ~/docker-volumes/mysql/data:/var/lib/mysql \
 -v ~/docker-volumes/mysql/conf/my.cnf:/etc/mysql/my.cnf \
 -e MYSQL_ROOT_PASSWORD=123456 \
 -p 3306:3306 \
 --restart=always \
 --name docker-mysql \
 -itd mysql:5.7 