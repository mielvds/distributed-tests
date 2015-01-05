#!bin/bash

ARGS=1

if [ $# -ne $ARGS ]
then
	echo "Usage: $0 <bucketname>"
	exit -1
fi

wget https://s3.amazonaws.com/bmtriplesdata/configS3.txt /home/ubuntu/
mv /home/ubuntu/configS3.txt /home/ubuntu/.s3cfg 
sed -i 's/AWS_AK/'$AWS_ACCESS_KEY'/' .s3cfg
sed -i 's/AWS_SK/'$AWS_SECRET_KEY'/' .s3cfg

sudo s3cmd get s3://$1/*.ttl /data/
sudo chmod a+rw /data/*.ttl
