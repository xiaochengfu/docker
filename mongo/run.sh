#!/bin/sh

docker run -p 27017:27017 \
    --restart=always \
    -v ~/docker-volumes/mongo/data/db:/data/db \
    -itd \
    --name docker-mongod  \
    -e MONGO_INITDB_ROOT_USERNAME=root \
    -e MONGO_INITDB_ROOT_PASSWORD=123456 \
    mongo --auth