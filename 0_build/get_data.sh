#!/bin/bash

wget https://s3.amazonaws.com/bmtriplesdata/configS3.txt /home/ubuntu/
mv /home/ubuntu/configS3.txt /home/ubuntu/.s3cfg 
sed -i 's/AWS_AK/'$AWS_ACCESS_KEY'/' .s3cfg
sed -i 's/AWS_SK/'$AWS_SECRET_KEY'/' .s3cfg
sudo s3cmd get s3://bmtriplesdata/*.sh /data/
sudo chmod a+rw /data/*.sh
sudo s3cmd get s3://bmtriplesdata/README_DATA /data/
sudo chmod a+rw /data/*.ttl
sudo s3cmd get s3://bmtriplesdata/*.ttl /data/
sudo chmod a+rw /data/README_DATA
