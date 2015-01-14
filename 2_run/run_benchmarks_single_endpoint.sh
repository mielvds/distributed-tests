#!/bin/bash

cd

mkdir ~/output
mkdir ~/output/fedx
mkdir ~/output/sesame
mkdir ~/output/mmlab

cd FedBench\ 3.0
chmod +x ./runEval.sh

# FedX
cp -a ./configuration_scripts_benchmarks/benchmark/single_endpoint/config_fedx ./configuration_scripts_benchmarks/benchmark/config
./runEval.sh

# DO SMTH WITH OUTPUT
cp -R ./result /home/ubuntu/output/fedx

# Sesame
cp -a ./configuration_scripts_benchmarks/benchmark/single_endpoint/config_sesame ./configuration_scripts_benchmarks/benchmark/config
./runEval.sh

# DO SMTH WITH OUTPUT
cp -R ./result /home/ubuntu/output/sesame

# MMLab Distributed SPARQL
cp -a ./configuration_scripts_benchmarks/benchmark/single_endpoint/config_mmlab ./configuration_scripts_benchmarks/benchmark/config
./runEval.sh

# DO SMTH WITH OUTPUT
cp -R ./result /home/ubuntu/output/mmlab
