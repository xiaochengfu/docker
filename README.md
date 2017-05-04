创建镜像：
在Dockerfile所在目录下执行：
docker build -t lnmp:v1 .

也可以执行如下命令，直接获取镜像包：
```
docker pull registry.cn-qingdao.aliyuncs.com/xiaochengfu/lnmp
```

启动镜像：
sh start

自定义启动信息：
```
docker run -itd --name=lnmp-v1 -v /data/docker/mysql/:/var/lib/mysql -v /data/docker/nginx/wwwroot/:/usr/local/nginx/html -v /data/docker/nginx/vhost/:/usr/local/nginx/conf/vhost -p 63306:3306 -p 680:80  lnmp:v1 bash
```

查看docker：
```
docker ps 
```
进入docker容器，启动服务：

```
docker exec -it 容器id bash
```

启动服务：
```
#mysql
service mysqld start

#php
service php-fpm start

#nginx
/usr/local/nginx/sbin/nginx
```

