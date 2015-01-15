#!/bin/bash

cd

mkdir ~/output
mkdir ~/output/fedx
mkdir ~/output/sesame
mkdir ~/output/mmlab


cd

cd ~/configuration/configuration_scripts_benchmarks/benchmark/single_endpoint/config_direct/sparql-query-bm-2.0.1/
rm result.csv
./benchmark -q http://10.0.0.10:8891/sparql -m mix.txt -r 5 -w 2 -c result.csv
cp ./result.csv /home/ubuntu/output/direct

cd FedBench\ 3.0
chmod +x ./runEval.sh

# FedX
cp -af ~/configuration_scripts_benchmarks/benchmark/single_endpoint/config_fedx/* ./config/
./runEval.sh

# DO SMTH WITH OUTPUT
cp -R ./result /home/ubuntu/output/fedx
rm -R ./result
mkdir ./result

# MMLab Distributed SPARQL
cp -af ~/configuration_scripts_benchmarks/benchmark/single_endpoint/config_mmlab/* ./config/
./runEval.sh

# DO SMTH WITH OUTPUT
cp -R ./result /home/ubuntu/output/mmlab
rm -R ./result
mkdir ./result

# Sesame
cp -af ~/configuration_scripts_benchmarks/benchmark/single_endpoint/config_sesame/* ./config/
./runEval.sh/

# DO SMTH WITH OUTPUT
cp -R ./result /home/ubuntu/output/sesame
rm -R ./result
mkdir ./result