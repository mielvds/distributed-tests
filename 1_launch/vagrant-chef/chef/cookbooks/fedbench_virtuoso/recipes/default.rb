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

  $port = ini['Parameters']['ServerPort']
  puts "Port: #{$port}"

  # Save it back to disk
  # You don't need to provide the filename, it remembers the original name
  ini.save
end

template "/etc/init.d/virtuoso" do
  mode "0755"
  source "init.erb"
end

service "virtuoso" do
  supports [ :stop, :start, :restart ]
  action [ :enable, :start ]
end

bash "setup_virtuoso" do
  # code "#{node['virtuoso']['bin']}virtuoso-t -c #{node['virtuoso']['config']} "
  # code "sleep 20"

  node['datasets'].each { | dataset |
    puts "### Loading #{dataset} into virtuoso..."
    code "#{node['virtuoso']['isql']} #{$port} #{node['virtuoso']['user']} #{node['virtuoso']['pass']} exec=\"ld_dir('#{dataset}', '*.ttl', '#{dataset}');\""
  }

  code "#{node['virtuoso']['isql']} #{$port} #{node['virtuoso']['user']} #{node['virtuoso']['pass']} exec=\"rdf_loader_run();\""

  puts "### Creating checkpoint for server #{$port}..."
  code "#{node['virtuoso']['isql']} #{$port} #{node['virtuoso']['user']} #{node['virtuoso']['pass']} exec=\"checkpoint;\""
end
