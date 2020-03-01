#!/bin/sh
if [ ! -d "/logs/redis" ]; then
	mkdir -p /logs/redis
fi

if [ ! -d "/data/redis" ]; then
	mkdir -p /data/redis
fi


# Check user & group
ug=$(ls -l /logs/redis | awk '{print $3":"$4}')
if [ "$ug" != "root:root" ]; then
	chown -R root:root /logs/redis
fi

ug=$(ls -l /data/redis | awk '{print $3":"$4}')
if [ "$ug" != "root:root" ]; then
	chown -R root:root /data/redis
fi