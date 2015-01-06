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
  code "/usr/local/virtuoso-opensource/bin/virtuoso-t"
  node['datasets'].each { | dataset |
    code <<-EOH
    ###########################################
    # Load files

    echo "### Loading data into virtuoso..."

    isql-vt -S #{node['virtuoso']['port']} exec="ld_dir('#{dataset}', '%.ttl', '#{dataset}')"

    EOH
  }
  code <<-EOH
  isql-vt -S #{node['virtuoso']['port']} exec="DB.DBA.rdf_loader_run();"

  # End
  ###########################################

  echo "### Creating checkpoint for server $PORT..."
  isql-vt -S #{node['virtuoso']['port']} exec="checkpoint"
  EOH
end
