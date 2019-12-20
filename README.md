> 本项目属于个人定制自己的本地开发环境，配置上倾向于个人习惯，仅供学习参考
### 构建镜像
1.构建nginx

进入nginx目录
```
docker build -t hp/nginx .
```
2.构建php

进入php目录
```
docker build -t hp/php .
```

### 使用场景一

直接使用docker-compose启动
#### 启动前

a.修改lnmp目录下的.env文件，NGINX_PROJECT和PHP_VOLUME_PROJECT指的是所有项目的所在路径，需要改成你自己的本地路径
#### 启动

进入lnmp目录
```
docker-compose up
```
> 验证是否启动
#### 1.检查nginx是否正常
浏览器中输入`127.0.0.1`

#### 2.检查php文件是否正常解析运行

a.修改你本机的host地址，添加如下：
`127.0.0.1  demo.local.com`
b.浏览器中输入
`demo.local.com`

> htdocs目录模拟的是你本地所有项目的所在目录，方便你测试

### 使用场景二
直接启用php服务
#### 1.启动laravel 服务
进入项目根目录
```
docker run -itd --rm -p 8000:8000 -v $PWD:/home/wwwroot:cached hp/php php artisan serve --host=0.0.0.0
```
#### 2.启动thinkphp 服务
进入项目根目录
```
docker run -itd --rm -p 8000:8000 -v $PWD:/home/wwwroot:cached hp/php php think run --host=0.0.0.0
```

### 使用场景三
需要使用nginx来做虚拟域名，nginx和php关联使用

#### 1.先启动php
进入php目录！！！
```
docker run -p 9000:9000 -v $PWD/conf/php.ini:/usr/local/etc/php/php.ini -v 你本地所有项目的所在目录:/home/wwwroot --name php -itd hp/php
```

#### 2.再启动nginx
进入nginx目录！！！
```
docker run -p 80:80 -v $PWD/conf/nginx.conf:/etc/nginx/nginx.conf -v $PWD/vhost:/etc/nginx/conf.d -v 你本地所有项目的所在目录:/home/wwwroot:cached --link php:php -itd  hp/nginx
```
nginx 参数说明：

a.`-v $PWD/conf/nginx.conf:/etc/nginx/nginx.conf`可选,将nginx.conf主配置文件挂载到宿主机，做持久化

b.`-v $PWD/vhost:/etc/nginx/conf.d `必选,设置后才可自定义虚拟域名

c.`-v 你本地所有项目的所在目录:/home/wwwroot`必选，把宿主机所有项目映射到容器中，做持久化

d.`--link php:php`必选，设置后，才能与php容器互通,参数说明：`--link php容器设置的name:别名`





#### 画重点

a. `你本地所有项目的所在目录` 要改成你自己的项目所在目录

b. `-v 你本地所有项目的所在目录:/home/wwwroot:cached`命令末尾的`:cached`指的是使用容器内缓存，提高速度
