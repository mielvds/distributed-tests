#!/bin/bash

cd

mkdir ~/output
mkdir ~/output/fedx
mkdir ~/output/ldf

cd FedBench\ 3.0
chmod +x ./runEval.sh

# FedX
cp -af ~/configuration_scripts_benchmarks/benchmark/fedbench_endpoints/config_fedx/* ./config/
./runEval.sh

# DO SMTH WITH OUTPUT
cp -R ./result /home/ubuntu/output/fedx

sources=('kegg-chebi' 'dbpedia' 'drugbank' 'geonames' 'linkedmdb' 'nytimes' 'jamendo' 'sp2b' 'swdf');

for i in "${sources[@]}"
do

# LDF
cp -af /home/ubuntu/FedBench 3.0/federated-ldf/config-${i}.json /home/ubuntu/FedBench 3.0/federated-ldf/config-fedbench.json
cp -af ~/configuration_scripts_benchmarks/benchmark/fedbench_endpoints/config_ldf/* ./config/
./runEval.sh

# DO SMTH WITH OUTPUT
mkdir ./result /home/ubuntu/output/ldf/${i}/
cp -R ./result /home/ubuntu/output/ldf/${i}/

done
