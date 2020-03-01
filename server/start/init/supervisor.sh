#!/bin/sh
if [ ! -d "/logs/supervisor" ]; then
	mkdir -p /logs/supervisor
fi

# Check user & group
ug=$(ls -l /logs/supervisor | awk '{print $3":"$4}')
if [ "$ug" != "root:root" ]; then
	chown -R root:root /logs/supervisor
fi