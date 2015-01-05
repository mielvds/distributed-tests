#!/bin/bash

wget https://dl.bintray.com/mitchellh/packer/packer_0.7.5_linux_amd64.zip 
mv packer_0.7.5_linux_amd64.zip /tmp
sudo unzip /tmp/packer_0.7.5_linux_amd64.zip -d /usr/local/packer
export PATH=$PATH:/usr/local/packer
packer build single_endpoints_aws_s3_to_ebs.json