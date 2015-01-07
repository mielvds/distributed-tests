#
# Cookbook Name:: fedbench_virtuoso
# Recipe:: prepare_virtuoso
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

chef_gem 'inifile'

require 'inifile'

# install the software we need
# %w(
# autoconf
# automake
# libtool
# flex
# bison
# gperf
# gawk
# m4
# make
# OpenSSL
# libssl-dev
# git
# s3cmd
# ).each { | pkg | package pkg }

if File.exists?(File.expand_path node['virtuoso']['config'])
  # Open and read the virtuoso file
  ini = IniFile::load(File.expand_path node['virtuoso']['config'])

  # Edit the contents
  ini['Parameters']['DirsAllowed'] = "#{ini['Parameters']['DirsAllowed']},#{node['datasets'].join(",")}"

  # Read its current contents
  puts ini['Parameters']['DirsAllowed']

  # Save it back to disk
  # You don't need to provide the filename, it remembers the original name
  ini.save
end

bash "setup_virtuoso" do
  code "#{node['virtuoso']['bin']}virtuoso-t -f -c #{node['virtuoso']['config']} "

  sleep(30)

  node['datasets'].each { | dataset |
    puts "### Loading #{dataset} into virtuoso..."
    code "#{node['virtuoso']['bin']}isql -S #{node['virtuoso']['port']} exec=\"ld_dir('#{dataset}', '*.ttl', '#{dataset}')\""
  }

  code "#{node['virtuoso']['bin']}isql -S #{node['virtuoso']['port']} exec=\"DB.DBA.rdf_loader_run();\""

  puts "### Creating checkpoint for server #{node['virtuoso']['port']}..."
  code "#{node['virtuoso']['bin']}isql -S #{node['virtuoso']['port']} exec=\"checkpoint\""
end
