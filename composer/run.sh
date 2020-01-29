#!/bin/sh

# 挂载.ssh是为了git免密拉取
# /home/wwwroot是输出的静态文件

docker run --rm -it \
 -u $(id -u):$(id -g) \
 -v $(pwd)/:/build  \
 -v $(pwd)/composer:/composer \
 -v /root/.ssh:/root/.ssh \
 -v /home/wwwroot/composer:/home/wwwroot/composer \
 composer/satis build satis.json /home/wwwroot/composer