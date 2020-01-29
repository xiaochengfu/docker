#!/bin/sh

docker run -itd \
  --restart=always \
  --name docker-yapi \
  --workdir /api/vendors \
  -p 3001:3000 \
  -v /usr/local/src/github-docker/yapi/conf/config.json:/api/config.json \
  registry.cn-hangzhou.aliyuncs.com/anoy/yapi \
  server/app.js