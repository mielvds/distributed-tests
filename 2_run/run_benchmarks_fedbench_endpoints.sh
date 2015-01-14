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

# LDF
cp -af ~/configuration_scripts_benchmarks/benchmark/fedbench_endpoints/config_ldf/* ./config/
./runEval.sh/

# DO SMTH WITH OUTPUT
cp -R ./result /home/ubuntu/output/ldf
