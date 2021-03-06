#!/bin/bash

# Update all packages.
sudo apt-get -y update
sudo apt-get install -y python-software-properties
sudo apt-get install -y nginx curl wget unzip build-essential s3cmd automake flex bison gawk gperf libtool libssl-dev
sudo apt-get -y upgrade

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

sudo locale-gen en_US.UTF-8
sudo dpkg-reconfigure locales
sudo touch /root/.locale-fixed
sudo /usr/sbin/update-locale

#Virtuoso
wget https://github.com/openlink/virtuoso-opensource/archive/48f0ef879b913c5d3b306c1f83390079c5416fe6.zip
unzip 48f0ef879b913c5d3b306c1f83390079c5416fe6.zip
cp configuration_scripts_benchmarks/virtuoso/getdate.y virtuoso-opensource-48f0ef879b913c5d3b306c1f83390079c5416fe6/libsrc/util/getdate.y
cd  virtuoso-opensource-48f0ef879b913c5d3b306c1f83390079c5416fe6/
env CFLAGS="-O2 -m64"
./autogen.sh
./configure --prefix=/home/ubuntu/progs/virtuoso-opensource-bin --disable-all-vads --with-pthreads --disable-openldap --disable-imsg
make -j5
make install
cd

# Virtuoso Configuration
#/home/ubuntu/progs/virtuoso-opensource-bin/var/lib/virtuoso/db
mkdir /home/ubuntu/virtuoso_data
cp ./configuration_scripts_benchmarks/virtuoso/virtuoso.ini /home/ubuntu/progs/virtuoso-opensource-bin/var/lib/virtuoso/db/virtuoso.ini
sudo ln -s /home/ubuntu/progs/virtuoso-opensource-bin/bin/isql /usr/bin/isql-vt
sudo ln -s /home/ubuntu/progs/virtuoso-opensource-bin/bin/virtuoso-t /usr/bin/virtuoso-t
cd

# Data Partition Configuration
sudo mkdir /data
sudo mkfs -t ext4 /dev/xvde
sudo mount  /dev/xvde /data
sudo cp /etc/fstab /etc/fstab.orig
sudo su -c "echo '/dev/xvde       /data   ext4    defaults,nofail        0       2' >> /etc/fstab"
sudo mount -a
sudo chown ubuntu:ubuntu /data

#Set hostname
sudo hostname singleinstance
sudo sh -c "echo '127.0.0.1 singleinstance.localdomain singleinstance' >> /etc/hosts"
sudo sh -c "echo 'singleinstance' > /etc/hostname"
sudo mkdir /etc/sysconfig
sudo touch /etc/sysconfig/network
sudo sh -c "echo 'HOSTNAME=singleinstance.localdomain' >> /etc/sysconfig/network"

cd