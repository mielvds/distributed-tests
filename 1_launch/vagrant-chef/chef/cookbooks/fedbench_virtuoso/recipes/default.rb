#
# Cookbook Name:: fedbench_virtuoso
# Recipe:: prepare_virtuoso
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

chef_gem 'inifile'
require 'inifile'

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

node['endpt']['datasets'].each { | dataset |
  bash "add_#{dataset}" do
    code <<-EOH
      echo "### Loading #{dataset} into virtuoso..."
      #{node['virtuoso']['isql']} #{$port} #{node['virtuoso']['user']} #{node['virtuoso']['pass']} exec="ld_dir('#{dataset}', '*.ttl', 'file://#{dataset}');"
    EOH
  end
}

bash "ingest_virtuoso" do
  code <<-EOH
    echo "### Ingesting data"
    #{node['virtuoso']['isql']} #{$port} #{node['virtuoso']['user']} #{node['virtuoso']['pass']} exec="rdf_loader_run();" &
    #{node['virtuoso']['isql']} #{$port} #{node['virtuoso']['user']} #{node['virtuoso']['pass']} exec="rdf_loader_run();" &
    #{node['virtuoso']['isql']} #{$port} #{node['virtuoso']['user']} #{node['virtuoso']['pass']} exec="rdf_loader_run();" &
    #{node['virtuoso']['isql']} #{$port} #{node['virtuoso']['user']} #{node['virtuoso']['pass']} exec="rdf_loader_run();" &
    #{node['virtuoso']['isql']} #{$port} #{node['virtuoso']['user']} #{node['virtuoso']['pass']} exec="rdf_loader_run();" &
    #{node['virtuoso']['isql']} #{$port} #{node['virtuoso']['user']} #{node['virtuoso']['pass']} exec="rdf_loader_run();" &
    #{node['virtuoso']['isql']} #{$port} #{node['virtuoso']['user']} #{node['virtuoso']['pass']} exec="rdf_loader_run();" &
    #{node['virtuoso']['isql']} #{$port} #{node['virtuoso']['user']} #{node['virtuoso']['pass']} exec="rdf_loader_run();" &
    wait
    #{node['virtuoso']['isql']} #{$port} #{node['virtuoso']['user']} #{node['virtuoso']['pass']} exec="checkpoint;"
    #{node['virtuoso']['isql']} #{$port} #{node['virtuoso']['user']} #{node['virtuoso']['pass']} exec="DB.DBA.RDF_OBJ_FT_RULE_ADD (null, null, 'All');"
    #{node['virtuoso']['isql']} #{$port} #{node['virtuoso']['user']} #{node['virtuoso']['pass']} exec="checkpoint;"
  EOH
end
