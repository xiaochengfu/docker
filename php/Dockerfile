FROM php:7.4-fpm

# 设置环境变量
ENV REDIS_VERSION=5.1.0
ENV SWOOLE_VERSION=4.4.12
ENV COMPOSER_VERSION=1.9.1

COPY conf/sources.list /opt/sources.list

# 设置工作目录，也就是php文件读取目录，一般为宿主机的项目入口文件
WORKDIR /home/wwwroot

# 使用阿里云源更新并安装gd库
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak \
    && mv /opt/sources.list /etc/apt/ \
    && apt-get update \
    && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    unixodbc-dev \
    procps \
    lsof \
    gcc g++ make autoconf libc-dev pkg-config \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd 

# 安装redis和pod_mysql扩展
COPY ext/redis-${REDIS_VERSION}.tgz /opt/redis.tgz
RUN docker-php-ext-install pdo_mysql \
    && pecl install /opt/redis.tgz \
    && docker-php-ext-enable redis 

# 安装swoole
COPY ext/swoole-${SWOOLE_VERSION}.tgz /opt/swoole.tgz
RUN pecl install /opt/swoole.tgz \
    && docker-php-ext-enable swoole 

# 安装composer
ADD ext/composer-${COMPOSER_VERSION}.phar /usr/local/bin/composer
RUN chmod 755 /usr/local/bin/composer

# 删除扩展包
RUN rm -rf /opt/*.tgz

# 设置执行用户
RUN usermod -u 1000 www-data

EXPOSE 9000


# export DOCKER_BUILDKIT=1 加在docker build前，可获取实时进度
