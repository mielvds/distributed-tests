#!/bin/bash

if which packer >/dev/null; then
    echo packer found
else
    wget https://dl.bintray.com/mitchellh/packer/packer_0.7.5_linux_amd64.zip 
    mv packer_0.7.5_linux_amd64.zip /tmp
    sudo unzip /tmp/packer_0.7.5_linux_amd64.zip -d /usr/local/packer
    export PATH=$PATH:/usr/local/packer
fi

packer build single_endpoints_aws_s3_to_ebs.json

packer build query_engine_aws.json