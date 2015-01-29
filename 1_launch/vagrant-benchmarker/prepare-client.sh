#!/bin/bash

cd
sudo apt-get update
sudo apt-get install default-jre
curl -sL https://deb.nodesource.com/setup | sudo bash -
sudo apt-get install -y nodejs
npm install -g node-gyp # Install the "node-gyp" globally.
cd ~
npm update # Update your personal npm local repository again.
# Prepare client
cd /home/ubuntu/FedBench\ 3.0/

git clone git@git.mmlab.be:mvdrsand/discoveryclient.git#Federated-progressive federated-ldf
cd federated-ldf
npm install
