> 本项目属于个人定制自己的本地开发环境，配置上倾向于个人习惯，仅供学习参考

lnmpComplex版本安装：

1.将本仓库git到本地，当然你可以自己在本地创建如下目录，主要是nginx的配置

2.获取docker镜像，此镜像安装了linux6、php7.2.6、nginx;php扩展有redis/mongodb/swoole

```
docker pull xiaochengfu/centos-6-lnp

```
3.其他服务自行docker pull,例如mysql/redis等

4.docker run 运行
```
docker run -p 80:80 -v /本地路径/nginx/conf/vhost/:/usr/local/nginx/conf/vhost -v /本地路径/wwwroot/:/home/wwwroot -itd 镜像id bash
```

5.进入容器，启动服务

```
docker exec -itd 容器id bash
```

6.在宿主机测试

```
访问：127.0.0.1

```