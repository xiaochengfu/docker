FROM centos:6

MAINTAINER houpeng  "xcf-hp@foxmail.com"

RUN echo "设置163的yum源" && \
	mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup

ADD http://mirrors.163.com/.help/CentOS6-Base-163.repo /etc/yum.repos.d/

RUN yum clean all && yum makecache

#安装mysql5
RUN echo "开始安装mysql" && yum install -y mysql-server mysql

RUN echo "启动mysql并设置root密码" && \
	/etc/init.d/mysqld start && \
    mysql -e "grant all privileges on *.* to 'root'@'%' identified by '8805623';"&&\
    mysql -e "grant all privileges on *.* to 'root'@'localhost' identified by '8805623';"&&\
    mysql -u root -p8805623 -e "show databases;"

EXPOSE 3306

#安装php7

RUN echo "更新php的yum源" && rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm

RUN echo "开始安装php" && yum install -y php70w php70w-fpm

RUN echo "启动php" && service php-fpm start

EXPOSE 9000

#安装nginx

RUN echo "安装依赖包" && yum install -y pcre-devel gcc make zlib wget zlib-devel openssl-devel

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

CMD ["/usr/local/nginx/sbin/nginx"]
