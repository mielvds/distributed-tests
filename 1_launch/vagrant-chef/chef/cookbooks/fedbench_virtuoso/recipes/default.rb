#
# Cookbook Name:: fedbench_virtuoso
# Recipe:: prepare_virtuoso
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

require 'inifile'

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

# Open and read the virtuoso file
ini = IniFile.load(node['virtuoso']['config'])

# Read its current contents
puts ini['Parameters']['DirsAllowed']

# Edit the contents
ini['Parameters']['DirsAllowed'] = "#{ini['Parameters']['DirsAllowed']},#{node['datasets'].join(",")}"

# Save it back to disk
# You don't need to provide the filename, it remembers the original name
ini.save

bash "setup_virtuoso" do
  code "virtuoso-t -c #{node['virtuoso']['config']}"
  node['datasets'].each { | dataset |
    puts ### Loading data into virtuoso...
    code "isql-vt -S #{node['virtuoso']['port']} exec=\"ld_dir('#{dataset}', '%.ttl', '#{dataset}')\""
  }

  code "isql-vt -S #{node['virtuoso']['port']} exec=\"DB.DBA.rdf_loader_run();\""

  puts "### Creating checkpoint for server #{node['virtuoso']['port']}..."
  code "isql-vt -S #{node['virtuoso']['port']} exec=\"checkpoint\""
end
