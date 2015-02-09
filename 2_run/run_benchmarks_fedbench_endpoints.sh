#!/bin/bash

cd

mkdir ~/output
mkdir ~/output/fedx
mkdir ~/output/ldf

cd FedBench\ 3.0
chmod +x ./runEval.sh

# FedX
#cp -af ~/configuration_scripts_benchmarks/benchmark/fedbench_endpoints/config_fedx/* ./config/
#./runEval.sh

# DO SMTH WITH OUTPUT
#cp -R ./result /home/ubuntu/output/fedx

cp -af ~/configuration_scripts_benchmarks/benchmark/fedbench_endpoints/config_ldf/* ./config/
sources=('kegg-chebi' 'dbpedia' 'drugbank' 'geonames' 'linkedmdb' 'nytimes' 'jamendo' 'swdf');

for i in "${sources[@]}"
do

# LDF
cp -af /home/ubuntu/FedBench\ 3.0/federated-ldf/config-${i}.json /home/ubuntu/FedBench\ 3.0/federated-ldf/config-fedbench.json
./runEval.sh

# DO SMTH WITH OUTPUT
mkdir /home/ubuntu/output/ldf/${i}/
cp -R ./result /home/ubuntu/output/ldf/${i}/

done
