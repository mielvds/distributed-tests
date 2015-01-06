#!/bin/bash

# Update all packages.
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

sudo hostname benchmarker
echo benchmarker | sudo tee /etc/hostname
sudo sh -c "echo '127.0.0.1 benchmarker' >> /etc/hosts"

cd
cp ./configuration_scripts_benchmarks/benchmark/FedBench\ 3.0.zip ./
unzip FedBench\ 3.0.zip