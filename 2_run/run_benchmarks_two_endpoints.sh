#!/bin/bash

cd

mkdir ~/output
mkdir ~/output/fedx
mkdir ~/output/sesame
mkdir ~/output/mmlab

cd FedBench\ 3.0
chmod +x ./runEval.sh

# FedX
cp -af ~/configuration_scripts_benchmarks/benchmark/two_endpoints/config_fedx/* ./config/
./runEval.sh

# DO SMTH WITH OUTPUT
cp -R ./result /home/ubuntu/output/fedx
rm -R ./result
mkdir ./result

# MMLab Distributed SPARQL
cp -af ~/configuration_scripts_benchmarks/benchmark/two_endpoints/config_mmlab/* ./config/
./runEval.sh

# DO SMTH WITH OUTPUT
cp -R ./result /home/ubuntu/output/mmlab
rm -R ./result
mkdir ./result

# Sesame
cp -af ~/configuration_scripts_benchmarks/benchmark/two_endpoints/config_sesame/* ./config/
./runEval.sh/

# DO SMTH WITH OUTPUT
cp -R ./result /home/ubuntu/output/sesame
rm -R ./result
mkdir ./result