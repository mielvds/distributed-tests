#!/bin/bash

cd
cd FedBench\ 3.0

# FedX
cp -a ./configuration_scripts_benchmarks/benchmark/single_endpoint/config_fedx ./configuration_scripts_benchmarks/benchmark/config
./runval.sh

# DO SMTH WITH OUTPUT

# Sesame
cp -a ./configuration_scripts_benchmarks/benchmark/single_endpoint/config_sesame ./configuration_scripts_benchmarks/benchmark/config
./runval.sh

# DO SMTH WITH OUTPUT

# MMLab Distributed SPARQL
cp -a ./configuration_scripts_benchmarks/benchmark/single_endpoint/config_mmlab ./configuration_scripts_benchmarks/benchmark/config
./runval.sh

# DO SMTH WITH OUTPUT

cp -a ./configuration_scripts_benchmarks/benchmark/single_endpoint/config_mmlab ./configuration_scripts_benchmarks/benchmark/config
./runval.sh

# DO SMTH WITH OUTPUT