### php 镜像使用文档


> ### 镜像说明

 #### 1.可自定义php版本，当前为php-7.4-fpm
 #### 2.支持php.ini,php-fpm.conf 可配置
 #### 3.已安装扩展 redis/swoole
 #### 4.已安装composer 


> ### 构建镜像
进入php目录
```
docker build -t hp/php .
```

> ### 使用 php-cli

#### (1).查看php版本
```
docker run -it --rm hp/php php -v
```
#### (2).查看php安装的扩展模块
```
docker run -it --rm hp/php php -m
```
#### (3).查看composer版本
```
docker run -it --rm hp/php composer -V
```
#### (4).启动服务，查看phpinfo
```
docker run -it --rm -p 9000:9000 -v $PWD:/home/wwwroot  hp/php php -S 0.0.0.0:9000
```

> ### 实际开发应用

#### (1).启动laravel 服务
进入项目根目录
```
docker run -itd --rm -p 8000:8000 -v $PWD:/home/wwwroot:cached hp/php php artisan serve --host=0.0.0.0
```
#### (2).启动thinkphp 服务
```
docker run -itd --rm -p 8000:8000 -v $PWD:/home/wwwroot:cached hp/php php think run --host=0.0.0.0
```
#### (3).踩坑点：
a. `--host=0.0.0.0` 注意这里不要写成127.0.0.1，这是在docker容器内起的服务，127.0.0.1是服务在宿主机访问的

b. 启动laravel服务的时候，在`/home/wwwroot`后加上`:cached`可使用到容器内的换成数据，提高请求速度,macOs系统下有效，文件更新以宿主机为主



