#!/bin/bash

if which packer >/dev/null; then
    echo packer found
else
    wget https://dl.bintray.com/mitchellh/packer/packer_0.7.5_linux_amd64.zip 
    mv packer_0.7.5_linux_amd64.zip /tmp
    sudo unzip /tmp/packer_0.7.5_linux_amd64.zip -d /usr/local/packer
    export PATH=$PATH:/usr/local/packer
fi

single_endpoint_id=$(packer build single_endpoints_aws_s3_to_ebs.json | tail -1)
echo single_endpoint
echo $single_endpoint_id
query_engine_id=$(packer build query_engine_aws.json | tail -1)
echo query_engine
echo $query_engine_id