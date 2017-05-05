安装方式：

方法一（推荐）：直接获取镜像包，在阿里云的仓库上，下载速度飞快：
```
docker pull registry.cn-qingdao.aliyuncs.com/xiaochengfu/lnmp:v2
```
方法二：自己build镜像，需要将此项目文件git到本地：
```
git clone https://github.com/xiaochengfu/docker-lnmp
```

然后在Dockerfile所在目录下执行：
```
docker build -t lnmp:v1 .  //lnmp:v1为自定义的镜像名称：版本号
```

自定义启动信息：
```
docker run -itd --name=aliyun-lnmp -v /data/docker/mysql/:/var/lib/mysql -v /data/docker/nginx/wwwroot/:/usr/local/nginx/html -v /data/docker/nginx/vhost/:/usr/local/nginx/conf/vhost -p 23306:3306 -p 280:80 registry.cn-qingdao.aliyuncs.com/xiaochengfu/lnmp:v2 bash
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
#默认密码为空，进入后可设置超级权限
grant all privileges on *.* to 'root'@'%' identified by '123456' with grant option;
flush privileges;
#即可远程登陆

#php
service php-fpm start

#nginx
/usr/local/nginx/sbin/nginx

#redis
service redis start
#默认密码为123456

#mongodb
/etc/init.d/mongod start

#支持swoole
```

nginx的配置文件，在宿主机的/data/docker/nginx下，vhost下的目录，可以直接放置其他server配置

网站的根目录，在宿主机的/data/docker/nginx/wwwroot 下

