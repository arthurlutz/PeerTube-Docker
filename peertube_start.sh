#!/bin/bash

/etc/init.d/postgresql start
/etc/init.d/nginx start

sleep 10

cd /home/peertube_user/PeerTube && su peertube_user -c 'NODE_ENV=production npm start'
