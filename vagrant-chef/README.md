## Requirements ##

- [Vagrant](https://www.vagrantup.com/)
- [Vagrant AWS provider](https://github.com/mitchellh/vagrant-aws)
    - `vagrant plugin install vagrant-aws`

## Usage ##

- Add a dummy box to be used by the AWS provider: `vagrant box add dummy https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box`
- Launch Vagrant: `vagrant up`
- After the tests you can
    - terminate all the servers: vagrant destroy
    - shut down all the servers: vagrant halt

## Issues ##
- If you get an error regarding certificates, you should execute the following `export SSL_CERT_DIR=/etc/ssl/certs` . It is a problem with Vagrant. I don't know if this is also an issue for Windows and/or Mac.
- The default provider for the Vagrant script here is AWS. You can also use the default, i.e. Virtualbox, however, you will need to load a image that already has Virtuoso pre-installed, because installing Virtuoso develop/7 hangs the chef script, however, this is not the case for stable/6.