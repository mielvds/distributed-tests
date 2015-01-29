#!/bin/bash

mkdir ./server-logs

for (( c=10; c<19; c++ ))
do
  sudo scp -o StrictHostKeyChecking=no -i /vagrant/aws ubuntu@10.0.0.$c:/vagrant/*.csv /home/ubuntu/server-logs/
  sudo scp -o StrictHostKeyChecking=no -r -i /vagrant/aws ubuntu@10.0.0.$c:ldf-server/summaries/ /home/ubuntu/server-logs/
  sudo scp -o StrictHostKeyChecking=no -r -i /vagrant/aws ubuntu@10.0.0.$c:ldf-server/logs/access.log /home/ubuntu/server-logs/10.0.0.10-access.log
done
