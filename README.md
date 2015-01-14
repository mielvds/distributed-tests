Script to Configure benchmark for Federated Querying
================================================

Prerequirements
----------------------
Configuration scripts for the benchmarks with FedBench and a variety of Query Engines.

Whatever you decide to do with these scripts:

DO NOT FORGET TO SET YOUR AMAZON CREDENTIALS IN THE ENVIRONMENT VARIABLES!

    export AWS_SECRET_KEY={{user `aws_secret_key`}}
    export AWS_ACCESS_KEY={{user `aws_access_key`}}
    export AWS_S3_BUCKETNAME={{user `aws_s3_bucketname`}}
    export SSH_KEYNAME={{user `aws_keyname`}}
    export SSH_KEY={{user `aws_pem_key_filepath`}}
    export CONFIG_FILE={{user `vagrant_launch_config_json_filepath`}}

DO NOT FORGET TO INSTALL THE AWS PROVIDER FOR VAGRANT after installing vagrant!

Get the latest Vagrant from: https://www.vagrantup.com/downloads.html for your system.

And then run

	sudo apt-get install ruby-dev
	vagrant plugin install vagrant-aws
	vagrant plugin install vagrant-omnibus

Configuration Procedure
---------------------------------

If you did not create the AMI's already.

Run

	./0_build/build_aws_images.sh

If you did not launch the instances needed for your benchmark yet

	cd ./1_launch/vagrant-chef/vagrant

The first time you need to add a dummy box

	vagrant box add dummy https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box

Then you can configure the data endoint instances

NOTE: Make sure that for the VPC you configure, you have DNS resolution enabled.

	vagrant up --provider=aws

To launch the benchmarker

	cd ./1_launch/vagrant-chef/vagrant-benchmarker

	vagrant up --provider=aws

To run the benchmarks log in to the benchmarker via ssh.