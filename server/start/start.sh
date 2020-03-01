#!/bin/bash
/start/init/nginx.sh
/start/init/redis.sh
/start/init/supervisor.sh
/usr/bin/supervisord -c /setting/defaults/supervisor/supervisord.conf