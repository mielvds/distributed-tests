#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.

# Create temporary folder structure on temporary disk
test -d /mnt/tmp             || mkdir -m 1777 /mnt/tmp
test -d /mnt/tmp/nginx       || mkdir -m 1777 -p /mnt/tmp/nginx
test -d /mnt/tmp/cache/nginx || mkdir -m 1777 -p /mnt/tmp/cache/nginx
test -d /mnt/log/nginx       || mkdir -m 1777 -p /mnt/log/nginx

# Copy HDT files to temporary disk for fast access
test -d /mnt/data             || mkdir -m 1777 /mnt/data
cp /data/* /mnt/data/

cd /home/ubuntu/ldf-server
sudo forever start -o out.log  -e err.log  ./bin/ldf-server ./config.json 4000 1

exit 0
