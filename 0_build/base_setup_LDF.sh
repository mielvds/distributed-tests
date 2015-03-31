#!/bin/bash

# Update all packages.
sudo apt-get -y update
sudo apt-get install -y python-software-properties
sudo apt-get install -y nginx curl wget unzip build-essential s3cmd automake flex bison gawk gperf libtool libssl-dev openssl git vim htop
# sudo apt-get -y upgrade

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

sudo locale-gen en_US.UTF-8
sudo dpkg-reconfigure locales
sudo touch /root/.locale-fixed
sudo /usr/sbin/update-locale

sudo chown -R ubuntu /usr/lib/

# Node & NPM
#curl -sL https://deb.nodesource.com/setup | sudo bash -
#sudo apt-get install -y nodejs
#sudo chown -R ubuntu ~/.npm
#npm install -g node-gyp # Install the "node-gyp" globally.
#cd ~
#npm update # Update your personal npm local repository again.
#npm -g install forever

# LDF Server
#git clone http://git.mmlab.be/mvdrsand/discoveryserver.git /home/ubuntu/ldf-server
#cd /home/ubuntu/ldf-server
#git checkout discovery
#mkdir summaries
#sudo npm install

# Data Partition Configuration
sudo mkdir /data
sudo mkfs -t ext4 /dev/xvde
sudo mount  /dev/xvde /data
sudo cp /etc/fstab /etc/fstab.orig
sudo su -c "echo '/dev/xvde       /data   ext4    defaults,nofail        0       2' >> /etc/fstab"
sudo mount -a
sudo chown ubuntu:ubuntu /data

#Set hostname
# sudo hostname singleinstance
# sudo sh -c "echo '127.0.0.1 singleinstance.localdomain singleinstance' >> /etc/hosts"
# sudo sh -c "echo 'singleinstance' > /etc/hostname"
# sudo mkdir /etc/sysconfig
# sudo touch /etc/sysconfig/network
# sudo sh -c "echo 'HOSTNAME=singleinstance.localdomain' >> /etc/sysconfig/network"

cd
