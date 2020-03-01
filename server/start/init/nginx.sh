#!/bin/bash

# 日志目录
if [ ! -d "/logs/nginx" ]; then
	mkdir -p /logs/nginx
fi

if [ ! -d "/logs/php-fpm" ]; then
	mkdir -p /logs/php-fpm
fi

# Check user & group
ug=$(ls -l /logs/nginx | awk '{print $3":"$4}')
if [ "$ug" != "www-data:www-data" ]; then
	chown -R www-data:www-data /logs/nginx
fi

ug=$(ls -l /logs/php-fpm | awk '{print $3":"$4}')
if [ "$ug" != "www-data:www-data" ]; then
	chown -R www-data:www-data /logs/php-fpm
fi