# YaoPHP Runtime Environment

```bash
docker run -d -p 80:80 -p 443:443 -p 127.0.0.1:6379:6379 -it yaoapp/yao-php:1.0.0

```

## Last version 1.0.0

Service:

|  Service |  Ports | User:Group | Command | Config | Log |  Data |
| :-- | :-- | :-- | :-- | :-- | :-- | :-- |
| Nginx | 80,443 | www-data:www-data | /usr/local/sbin/nginx | /setting/defaults/nginx/nginx.conf | /logs/nginx/*.log | /code |
| PHP-FPM |/var/run/php7-fpm.sock |  www-data:www-data | /usr/local/sbin/php-fpm | /setting/defaults/php/fpm/php.ini & php-fpm.conf | /logs/php-fpm/*.log |
| Redis | 6379 | root:root | /usr/local/bin/redis-server | /setting/defaults/redis/redis.conf | /logs/redis/*.log | /data/redis |

Environment:

| Software | Version | Introduction |
| :-- | :-- | :-- |  
| Ubuntu |  18.04 LTS | FROM ubuntu:18.04 |
| Nginx | 1.16.1 | Source: [nginx-1.16.1.tar.gz](download/nginx-1.16.1.tar.gz)  |
| PHP | 7.2.26  | Source: [php-7.2.26.tar.gz](download/php-7.2.26.tar.gz)  |
| Redis | 5.0.4 | Source: [redis-5.0.4.tar.gz](redis-5.0.4.tar.gz)  |

Start Command:

| Script | Introduction |
| :-- | :-- |
| /start/start.sh | Start Redis, Nginx And PHP-FPM |

## Nginx configuration

```bash
--with-cc-opt='-g -O3 -fdebug-prefix-map=/build/nginx-DUghaW/nginx-1.14.0=. -fstack-protector-strong -Wformat -Werror=format-security -fPIC -Wdate-time -D_FORTIFY_SOURCE=2'
--with-ld-opt='-Wl,-Bsymbolic-functions -Wl,-z,relro -Wl,-z,now -fPIC'
--prefix=/usr/local
--conf-path=/etc/nginx/nginx.conf
--http-log-path=/var/log/nginx/access.log
--error-log-path=/var/log/nginx/error.log
--lock-path=/var/lock/nginx.lock
--pid-path=/var/run/nginx.pid
--modules-path=/usr/local/lib/nginx/modules
--http-client-body-temp-path=/var/lib/nginx/body
--http-fastcgi-temp-path=/var/lib/nginx/fastcgi
--http-proxy-temp-path=/var/lib/nginx/proxy
--http-scgi-temp-path=/var/lib/nginx/scgi
--http-uwsgi-temp-path=/var/lib/nginx/uwsgi
--with-mail=dynamic
--with-pcre=../pcre-8.43
--with-openssl=../openssl-1.1.1d
--with-zlib=../zlib-1.2.11
--with-stream
--with-stream_realip_module
--with-stream_geoip_module
--with-pcre-jit
--with-http_ssl_module
--with-http_stub_status_module
--with-http_realip_module
--with-http_auth_request_module
--with-http_v2_module
--with-http_dav_module
--with-http_slice_module
--with-threads
--with-http_addition_module
--with-http_geoip_module=dynamic
--with-http_gunzip_module
--with-http_gzip_static_module
--with-http_image_filter_module=dynamic
--with-http_sub_module
--with-http_xslt_module=dynamic
--with-stream=dynamic
--with-stream_ssl_module
--with-mail=dynamic
--with-mail_ssl_module
```

## PHP configuration

```bash
--enable-fpm
--with-fpm-user=www-data
--with-fpm-group=www-data
--with-mysqli=mysqlnd
--with-pdo-mysql=mysqlnd
--with-iconv-dir
--with-freetype-dir=/usr
--with-libxml-dir=/usr
--with-zlib
--with-gd
--with-jpeg-dir=/usr
--with-png-dir=/usr
--with-webp-dir=/usr
--with-xpm-dir=/usr
--with-curl
--with-readline
--with-openssl
--with-xmlrpc
--with-bz2
--with-gettext
--with-mysqli
--with-mhash
--with-imap
--with-imap-ssl
--with-kerberos
--enable-calendar
--enable-dba
--enable-exif
--enable-fileinfo
--enable-ftp
--enable-sysvshm
--enable-wddx
--enable-xml
--enable-bcmath
--enable-shmop
--enable-sysvsem
--enable-sysvmsg
--enable-inline-optimization
--enable-mbregex
--enable-mbstring
--enable-pcntl
--enable-sockets
--enable-zip
--enable-soap
--enable-opcache
--enable-intl
--with-sodium
--with-xsl
--disable-rpath

```

## PHP Modules

```bash
apc
apcu
bcmath
bz2
calendar
Core
ctype
curl
date
dba
dom
exif
fileinfo
filter
ftp
gd
gettext
hash
iconv
imagick
imap
intl
json
libxml
mbstring
mcrypt
mysqli
mysqlnd
openssl
pcntl
pcre
PDO
pdo_mysql
pdo_sqlite
Phar
phpiredis
posix
readline
redis
Reflection
session
shmop
SimpleXML
soap
sockets
sodium
SPL
sqlite3
standard
swoole
sysvmsg
sysvsem
sysvshm
tokenizer
wddx
xdebug
xdiff
xml
xmlreader
xmlrpc
xmlwriter
xsl
yaml
Zend OPcache
zip
zlib

# Zend Modules
Xdebug
Zend OPcache
```
