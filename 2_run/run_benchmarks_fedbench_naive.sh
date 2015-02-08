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
cp cp -af /home/ubuntu/FedBench\ 3.0/federated-ldf/ldf-client-naive.js /home/ubuntu/FedBench\ 3.0/federated-ldf/ldf-client.js

cp -af ~/configuration_scripts_benchmarks/benchmark/fedbench_endpoints/config_ldf/* ./config/

# LDF
cp -af /home/ubuntu/FedBench\ 3.0/federated-ldf/config-federated-all.json /home/ubuntu/FedBench\ 3.0/federated-ldf/config-fedbench.json
./runEval.sh

# DO SMTH WITH OUTPUT
mkdir ./result /home/ubuntu/output/ldf/all/
cp -R ./result /home/ubuntu/output/ldf/all/

done
