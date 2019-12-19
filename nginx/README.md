### nginx 镜像使用文档


> ### 镜像说明

 #### 1.可自定义nginx版本，当前为nginx:1.17


> ### 构建镜像
进入nginx目录
```
docker build -t hp/nginx .
```

#### 先启动php
进入php目录！！！
```
docker run -p 9000:9000 -v $PWD/conf/php.ini:/usr/local/etc/php/php.ini -v /Volumes/Transcend/htdocs:/home/wwwroot --name php -itd hp/php
```

#### 启动nginx
进入nginx目录！！！
```
docker run -p 80:80 -v $PWD/conf/nginx.conf:/etc/nginx/nginx.conf -v $PWD/vhost:/etc/nginx/conf.d -v /Volumes/Transcend/htdocs:/home/wwwroot:cached --link php:php -itd  hp/nginx
```
nginx 参数说明：

a.`-v $PWD/conf/nginx.conf:/etc/nginx/nginx.conf`可选,将nginx.conf主配置文件挂载到宿主机，做持久化

b.`-v $PWD/vhost:/etc/nginx/conf.d `必选,设置后才可自定义虚拟域名

c.`-v /Volumes/Transcend/htdocs:/home/wwwroot`必选，把宿主机所有项目映射到容器中，做持久化

d.`--link php:php`必选，设置后，才能与php容器互通,参数说明：`--link php容器设置的name:别名`



#### 画重点

a. `/Volumes/Transcend/htdocs` 要改成你自己的项目所在目录
b. `-v /Volumes/Transcend/htdocs:/home/wwwroot:cached`命令末尾的`:cached`指的是使用容器内缓存，提高速度
