#!/bin/sh

docker run --name docker-registry \
 -p 5000:5000 \
 --restart=always \
 -v ~/docker-volumes/registry:/var/lib/registry \
 -itd registry 