#
# Cookbook Name:: fedbench_virtuoso
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

# install the software we need
%w(
autoconf
automake
libtool
flex
bison
gperf
gawk
m4
make
OpenSSL
libssl-dev
git
s3cmd
).each { | pkg | package pkg }

bash "setup_virtuoso" do
  	code <<-EOH
	if [ #{node['install_virtuoso']} == "true" ] && [ ! -d /virtuoso-opensource ]; then
               mkdir /virtuoso-opensource
               cd /virtuoso-opensource
               git clone https://github.com/openlink/virtuoso-opensource.git /virtuoso-opensource
               ./autogen.sh
               ./configure
       		make
		make install
	fi

	/vagrant/prepareAndMountDrives.sh
  s3cmd -c /vagrant/.s3cfg get s3://fedbench/#{node['dataset']}/virtuoso.db.xz /mnt/drive1/virtuoso/virtuoso.db.xz
  s3cmd -c /vagrant/.s3cfg get s3://fedbench/#{node['dataset']}/virtuoso-temp.db /mnt/drive2/virtuoso/virtuoso-temp.db
  cd /mnt/drive1/virtuoso
  xz -d virtuoso.db.xz
  cp /vagrant/virtuoso.ini ./virtuoso.ini
	/usr/local/virtuoso-opensource/bin/virtuoso-t
	EOH
#	if [ ! -d /virtuoso-opensource ]; then
#		mkdir /virtuoso-opensource
#		cd /virtuoso-opensource
#		git clone https://github.com/openlink/virtuoso-opensource.git /virtuoso-opensource
#		./autogen.sh
#		./configure
#		make
#		make install
#	fi

#	/vagrant/prepareAndMountDrives.sh
#	s3cmd -c /vagrant/.s3cfg get s3://fedbench/#{node['source']['name']}/virtuoso.db.xz /mnt/drive1/virtuoso/virtuoso.db.xz
#	s3cmd -c /vagrant/.s3cfg get s3://fedbench/#{node['source']['name']}/virtuoso-temp.db /mnt/drive2/virtuoso/virtuoso-temp.db
#	cd /mnt/drive1/virtuoso
#	xz -d virtuoso.db.xz
#	cp /vagrant/virtuoso.ini ./virtuoso.ini
#	EOH
#	/usr/local/virtuoso-opensource/bin/virtuoso-t
#	EOH

end

#bash "done" do
#code <<-EOH
# echo aaa
#EOH
#end
