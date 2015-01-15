include_recipe "nodejs::npm"

bash "set default locale to UTF-8" do
  code <<-EOH
update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
dpkg-reconfigure locales
EOH
end
#
# dont't prompt for host key verfication (if any)
template "/home/vagrant/.ssh/config" do
  user "vagrant"
  group "vagrant"
  mode "0600"
  source "config"
end

execute "apt-get update"
package "python-software-properties"

# install the software we need
%w(
curl
vim
git
nodejs
build-essential
openssl
libssl-dev
).each { | pkg | package pkg }

template "/home/vagrant/.bash_aliases" do
  user "vagrant"
  mode "0644"
  source ".bash_aliases.erb"
end

template "/home/vagrant/.bash_profile" do
  user "vagrant"
  group "vagrant"
  source ".bash_profile"
end

#install the nodejs server
git "/ldf-server" do
  repository "http://git.mmlab.be/linked-data-fragments/server.git"
  revision "discovery"
  action :sync
  user "vagrant"
end

# Create JSON configuration
template "/ldf-server/config.json" do
  source "config.json.erb"
  variables(
    :source => node['source']
  )
  user "vagrant"
  group "vagrant"
  mode 0664
end

# Create data directory
directory "/data" do
  owner "vagrant"
  group "vagrant"
  mode 0664
  action :create
end

# Get HDT data file
remote_file "/data/#{node['source']}.hdt" do
  source "ftp://monn.elis.ugent.be/#{source['name']}.hdt"
end

nodejs_npm 'ldf-server' do
  path '/ldf-server'
  json true
  user 'vagrant'
end

# Get perfmon
remote_file "/perfmon-2.1b1.tgz" do
  source "http://softlayer-ams.dl.sourceforge.net/project/perfmon/perfmon/2.1b1/perfmon-2.1b1.tgz"
  action :create_if_missing
end
