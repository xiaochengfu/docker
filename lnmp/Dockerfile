FROM centos:6

MAINTAINER houpeng  "xcf-hp@foxmail.com"

ENV PWD 123456

#安装mysql5
RUN echo "开始安装mysql" && yum install -y mysql-server mysql

RUN echo "启动mysql并设置root密码" && \
	/etc/init.d/mysqld start && \
    mysql -e "grant all privileges on *.* to 'root'@'%' identified by '$PWD';"&&\
    mysql -e "grant all privileges on *.* to 'root'@'localhost' identified by '$PWD';"&&\
    mysql -u root -p$PWD -e "show databases;"

EXPOSE 3306

#安装php7

RUN echo "更新php的yum源" && rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm

RUN echo "开始安装php" && yum install -y php70w php70w-devel php70w-fpm php70w-gd php70w-pdo php70w-mysql

RUN echo "启动php" && service php-fpm start

EXPOSE 9000

#安装nginx

RUN echo "安装依赖包" && yum install -y epel-release pcre-devel gcc make zlib wget zlib-devel openssl-devel

COPY ./src/nginx-1.10.1.tar.gz /usr/local/src/nginx-1.10.1.tar.gz

RUN echo "开始解压nginx" && tar -C /usr/local/src -xvf /usr/local/src/nginx-1.10.1.tar.gz

RUN mkdir -p /usr/local/nginx/conf/vhost

RUN echo "开始编译安装" && \
	cd /usr/local/src/nginx-1.10.1 && \
	./configure \
	--prefix=/usr/local/nginx \
	--with-http_realip_module \
	--with-http_sub_module \
	--with-http_gzip_static_module \
	--with-http_stub_status_module  \
	--with-pcre \
	--with-http_ssl_module && \
	make && \
	make install

COPY ./config/nginx.conf /usr/local/nginx/conf/nginx.conf

RUN echo "<?php phpinfo();?>" > /usr/local/nginx/html/index.php

EXPOSE 80

#安装redis

RUN echo "安装redis" && yum install -y redis php70w-pecl-redis

RUN sed -i 's/# requirepass foobared/requirepass 123456/g' /etc/redis.conf

#安装mongodb

COPY ./config/mongodb-org-3.4.repo /etc/yum.repos.d/mongodb-org-3.4.repo

RUN echo "安装mongodb" && yum clean all && yum install -y mongodb-org php70w-pecl-mongodb

#安装swoole

ADD https://github.com/swoole/swoole-src/archive/v1.9.9.tar.gz /usr/local/src/v1.9.9.tar.gz

RUN tar -C /usr/local/src/ -xvf /usr/local/src/v1.9.9.tar.gz

WORKDIR /usr/local/src/swoole-src-1.9.9

RUN echo "编译安装swoole" && \
	phpize && \
	./configure && \
	make && \
	make install

RUN echo ";extension-swoole" >> /etc/php.ini && \
	echo "extension=swoole.so" >> /etc/php.ini

RUN echo "重启php" && service php-fpm start

RUN echo "清空下载的文件" && \
	rm -rf /usr/local/src/*

CMD ["/usr/local/nginx/sbin/nginx"]