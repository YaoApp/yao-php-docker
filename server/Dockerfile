# YaoPHP Runtime Environment ( Nginx + PHP + Redis )
#
#  Ubuntu 18.04.1 LTS
#
# --------------------------------
#
#  Nginx 1.16.1
#
#  CONF: /setting/defaults/nginx/nginx.conf 
#  ROOT: /code
#  LOG : /logs/nginx
#
# --------------------------------
#
#  PHP 7.2.26
#
#  php.ini: /setting/defaults/php/fpm/php.ini 
#  php-fpm: /setting/defaults/php/fpm/php-fpm.conf
#  LOG    : /logs/php-fpm
#
# --------------------------------
#
#  Redis 5.0.4
#
#  CONF: /setting/defaults/redis/redis.conf
#  DATA: /data/redis
#  LOG : /logs/redis
#
# --------------------------------
#
# BUILD:
#   docker build -t yaoapp/yao-php:1.0.0 .
#
# TEST:
#   docker run --rm -p 80:80 -p 443:443 -p 127.0.0.1:6379:6379 -it yaoapp/yao-php:1.0.0 /bin/bash
# 
# REMOVE:
#   docker rmi yaoapp/yao-php:1.0.0
#
FROM ubuntu:18.04
#
# Default configure
#
ADD conf /setting/defaults
ADD download /download
ADD start /start
ADD code /code
#
# Compile environment
#
RUN cd /tmp  && \
	apt-get update  && \
	apt-get install -y vim git libreadline-dev libncurses5-dev libpcre3-dev curl \
	ca-certificates  \
	ffmpeg \
    re2c \
    bison \
    apt-utils \
    debconf-utils \
    iputils-ping \
    xz-utils \
	libxml2-dev wget perl make gcc g++  libxpm-dev libyaml-dev net-tools \
	automake autoconf libtool binutils \
	libc-client2007e libc-client2007e-dev libkrb5-dev \
	libmagickwand-dev \
    libcurl4-openssl-dev libgnutls28-dev libssl-dev perl make build-essential  \
    libxrender1 libxtst6 libxi6 libnss3 libxss1 libatk-bridge2.0-0 libgtk-3-0 \
    libmcrypt-dev bash  bzip2  libpng-dev libbz2-dev libfreetype6-dev libwebp-dev libjpeg-dev gettext \
    libzip-dev libxslt1-dev libsodium-dev libgd-dev libgeoip-dev \
    zip \
    supervisor
#
# mhash
#
RUN cd /tmp && \
    tar xfz /download/mhash-0.9.9.9.tar.gz  && \
    cd mhash-0.9.9.9 && \
    CFLAGS="-O3 -fPIC"  ./configure --prefix=/usr && \
    make && \
    make install 
#
# Redis
#
RUN cd /tmp  && \
    tar xfz /download/redis-5.0.4.tar.gz  && \
    cd redis-5.0.4 && \
    make MALLOC=libc && \
    make install
#
# hiredis-0.14.0.tar 
#
RUN cd /tmp && \
    tar xfz /download/hiredis-0.14.0.tar.gz  && \
    cd hiredis-0.14.0 && \
    make && \
    make install 
#
# libxdiff
#
RUN cd /tmp && \
    tar xfz /download/libxdiff-0.22.tar.gz && \
    cd libxdiff-0.22 && \
    ./configure  && \
    make && \
    make install 
# 
# PHP 7.2.26
# 
RUN cd /tmp && \
    tar xfz /download/php-7.2.26.tar.gz && \
    cd php-7.2.26  && \
    CFLAGS="-O3 -fPIC" ./configure \
	--enable-fpm \
	--with-fpm-user=www-data \
	--with-fpm-group=www-data \
	--with-mysqli=mysqlnd \
	--with-pdo-mysql=mysqlnd \
	--with-iconv-dir \
	--with-freetype-dir=/usr \
	--with-libxml-dir=/usr \
	--with-zlib \
	--with-gd \
	--with-jpeg-dir=/usr --with-png-dir=/usr --with-webp-dir=/usr  --with-xpm-dir=/usr \
	--with-curl \
	--with-readline \
	--with-openssl \
	--with-xmlrpc \
	--with-bz2 \
	--with-gettext \
	--with-mysqli \
	--with-mhash \
	--with-imap  \
	--with-imap-ssl \
	--with-kerberos \
	--enable-calendar \
	--enable-dba \
	--enable-exif \
	--enable-fileinfo \
	--enable-ftp \
	--enable-sysvsem \
	--enable-sysvshm \
	--enable-wddx \
	--enable-xml \
	--enable-bcmath \
	--enable-shmop \
	--enable-sysvsem \
	--enable-sysvmsg \
	--enable-inline-optimization \
	--enable-mbregex \
	--enable-mbstring \
	--enable-pcntl \
	--enable-sockets \
	--enable-zip \
	--enable-soap \
	--enable-opcache \
    --enable-intl \
    --with-sodium \
    --with-xsl \
	--disable-rpath && \
	make && make install
#
# Opcache
#
RUN echo ";opcache-ext" >> /usr/local/lib/php.ini && \
    echo "zend_extension=opcache.so" >> /usr/local/lib/php.ini
#
# Xdebug
#
RUN cd /tmp && \
    tar xfz /download/xdebug-2.6.0.tgz && \
    cd xdebug-2.6.0  && \
    /usr/local/bin/phpize && \
    CFLAGS="-O3 -fPIC"  ./configure --enable-xdebug && \
    CFLAGS="-O3 -fPIC"  make && make install && \
    echo ";xdebug-ext" >> /usr/local/lib/php.ini && \
	echo "zend_extension=xdebug.so" >> /usr/local/lib/php.ini
#
# PHPRedis 
#
RUN cd /tmp && \
    tar xfz /download/phpredis-4.3.0.tar.gz && \
    cd phpredis-4.3.0  && \
    /usr/local/bin/phpize && \
    CFLAGS="-O3 -fPIC"  ./configure --with-php-config=/usr/local/bin/php-config && \
    CFLAGS="-O3 -fPIC"  make && make install && \
    echo ";redis-ext" >> /usr/local/lib/php.ini && \
	echo "extension=redis.so" >> /usr/local/lib/php.ini
#
# Phpiredis
#
RUN cd /tmp && \
    tar xfz /download/phpiredis-1.0.0.tar.gz && \
    cd phpiredis-1.0.0  && \
    /usr/local/bin/phpize && \
    CFLAGS="-O3 -fPIC"  ./configure --with-php-config=/usr/local/bin/php-config && \
    CFLAGS="-O3 -fPIC"  make && make install && \
    echo ";phpiredis-ext" >> /usr/local/lib/php.ini && \
	echo "extension=phpiredis.so" >> /usr/local/lib/php.ini
#
# Imagick
#
RUN cd /tmp && \
    tar xfz /download/imagick-3.4.3.tgz && \
    cd imagick-3.4.3  && \
    /usr/local/bin/phpize && \
    CFLAGS="-O3 -fPIC"  ./configure --with-php-config=/usr/local/bin/php-config && \
    CFLAGS="-O3 -fPIC"  make && make install && \
    echo ";imagick-ext" >> /usr/local/lib/php.ini && \
	echo "extension=imagick.so" >> /usr/local/lib/php.ini
#
# Swoole
#
RUN cd /tmp && \
    tar xfz /download/swoole-src-4.4.5.tar.gz && \
    cd swoole-src-4.4.5  && \
    /usr/local/bin/phpize && \
    CFLAGS="-O3 -fPIC"  ./configure --enable-openssl --enable-sockets --enable-http2 --enable-mysqlnd --with-php-config=/usr/local/bin/php-config && \
    CFLAGS="-O3 -fPIC"  make && make install && \
    echo ";swoole-ext" >> /usr/local/lib/php.ini && \
	echo "extension=swoole.so" >> /usr/local/lib/php.ini
#
# Xdiff
#
RUN cd /tmp && \
    tar xfz /download/xdiff-2.0.1.tgz && \
    cd xdiff-2.0.1  && \
    /usr/local/bin/phpize && \
    CFLAGS="-O3 -fPIC"  ./configure --with-php-config=/usr/local/bin/php-config && \
    CFLAGS="-O3 -fPIC"  make && make install && \
    echo ";xdiff-ext" >> /usr/local/lib/php.ini && \
	echo "extension=xdiff.so" >> /usr/local/lib/php.ini
#
# Mcrypt
#
RUN cd /tmp && \
    tar xfz /download/mcrypt-1.0.1.tgz && \
    cd mcrypt-1.0.1  && \
    /usr/local/bin/phpize && \
    CFLAGS="-O3 -fPIC"  ./configure --with-php-config=/usr/local/bin/php-config && \
    CFLAGS="-O3 -fPIC"  make && make install && \
    echo ";mcrypt-ext" >> /usr/local/lib/php.ini && \
	echo "extension=mcrypt.so" >> /usr/local/lib/php.ini
#
# Yaml
#
RUN cd /tmp && \
    tar xfz /download/yaml-2.0.4.tgz && \
    cd yaml-2.0.4  && \
    /usr/local/bin/phpize && \
    CFLAGS="-O3 -fPIC"  ./configure --with-php-config=/usr/local/bin/php-config && \
    CFLAGS="-O3 -fPIC"  make && make install && \
    echo ";yaml-ext" >> /usr/local/lib/php.ini && \
	echo "extension=yaml.so" >> /usr/local/lib/php.ini
#
# Apcu
#
RUN cd /tmp && \
    tar xfz /download/apcu-5.1.16.tgz && \
    cd apcu-5.1.16  && \
    /usr/local/bin/phpize && \
    CFLAGS="-O3 -fPIC"  ./configure --with-php-config=/usr/local/bin/php-config && \
    CFLAGS="-O3 -fPIC"  make && make install && \
    echo ";apcu-ext" >> /usr/local/lib/php.ini && \
	echo "extension=apcu.so" >> /usr/local/lib/php.ini
#
# Apc
#
RUN cd /tmp && \
    tar xfz /download/apcu_bc-1.0.4.tgz && \
    cd apcu_bc-1.0.4  && \
    /usr/local/bin/phpize && \
    CFLAGS="-O3 -fPIC"  ./configure --with-php-config=/usr/local/bin/php-config && \
    CFLAGS="-O3 -fPIC"  make && make install && \
    echo ";apc-ext" >> /usr/local/lib/php.ini && \
	echo "extension=apc.so" >> /usr/local/lib/php.ini
#
# Nginx 
#
RUN cd /tmp && \
    tar xfz /download/pcre-8.43.tar.gz && \
    tar xfz /download/openssl-1.1.1d.tar.gz && \
    tar xfz /download/zlib-1.2.11.tar.gz && \
    tar xfz /download/nginx-1.16.1.tar.gz && \
    cd nginx-1.16.1  && \
    ./configure \
    --with-cc-opt='-g -O3 -fdebug-prefix-map=/build/nginx-DUghaW/nginx-1.14.0=. -fstack-protector-strong -Wformat -Werror=format-security -fPIC -Wdate-time -D_FORTIFY_SOURCE=2' \
    --with-ld-opt='-Wl,-Bsymbolic-functions -Wl,-z,relro -Wl,-z,now -fPIC' \
    --prefix=/usr/local \
    --conf-path=/etc/nginx/nginx.conf \
    --http-log-path=/var/log/nginx/access.log \
    --error-log-path=/var/log/nginx/error.log \
    --lock-path=/var/lock/nginx.lock \
    --pid-path=/var/run/nginx.pid \
    --modules-path=/usr/local/lib/nginx/modules \
    --http-client-body-temp-path=/var/lib/nginx/body \
    --http-fastcgi-temp-path=/var/lib/nginx/fastcgi \
    --http-proxy-temp-path=/var/lib/nginx/proxy \
    --http-scgi-temp-path=/var/lib/nginx/scgi \
    --http-uwsgi-temp-path=/var/lib/nginx/uwsgi \
    --with-mail=dynamic \
    --with-pcre=../pcre-8.43 \
    --with-openssl=../openssl-1.1.1d \
    --with-zlib=../zlib-1.2.11 \
    --with-stream \
    --with-stream_realip_module \
    --with-stream_geoip_module  \
    --with-pcre-jit \
    --with-http_ssl_module \
    --with-http_stub_status_module \
    --with-http_realip_module \
    --with-http_auth_request_module \
    --with-http_v2_module \
    --with-http_dav_module \
    --with-http_slice_module \
    --with-threads \
    --with-http_addition_module \
    --with-http_geoip_module=dynamic \
    --with-http_gunzip_module \
    --with-http_gzip_static_module \
    --with-http_image_filter_module=dynamic \
    --with-http_sub_module \
    --with-http_xslt_module=dynamic \
    --with-stream=dynamic \
    --with-stream_ssl_module \
    --with-mail=dynamic \
    --with-mail_ssl_module && \
    make && make install && mkdir /var/lib/nginx 
#
# Add web user and group
#
RUN mkdir -p /data/redis && mkdir /config && mkdir -p /logs/redis  && mkdir -p /logs/nginx && mkdir -p /logs/php-fpm
RUN chown -R www-data:www-data /logs/nginx && chown -R www-data:www-data /logs/php-fpm
RUN chmod -R 0644 /setting && chmod +x /start/*.sh && chmod +x /start/*/*.sh
EXPOSE 80 443 6379
CMD ["sh", "/start/start.sh"]