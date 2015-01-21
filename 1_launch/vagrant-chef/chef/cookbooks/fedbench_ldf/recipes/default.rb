bash 'set default locale to UTF-8' do
  code <<-EOH
  update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
  dpkg-reconfigure locales
  EOH
end
#
# dont't prompt for host key verfication (if any)
# template '/home/vagrant/.ssh/config' do
#   mode '0600'
#   source 'config'
# end

execute 'apt-get update'
package 'python-software-properties'

# install the software we need
%w(
curl
vim
git
build-essential
openssl
libssl-dev
).each { | pkg | package pkg }

template '/home/ubuntu/.bash_profile' do
  source '.bash_profile'
end

bash 'Install node and npm' do
  code <<-EOH
  curl -sL https://deb.nodesource.com/setup | sudo bash -
  sudo apt-get install -y nodejs
  npm install -g node-gyp # Install the "node-gyp" globally.
  cd ~
  npm update # Update your personal npm local repository again.
  EOH
end

# install the nodejs server
git '/home/ubuntu/ldf-server' do
  repository 'http://git.mmlab.be/mvdrsand/discoveryserver.git'
  revision 'discovery'
  action :sync
end

# Create JSON configuration
template '/home/ubuntu/ldf-server/config.json' do
  source 'config.json.erb'
  variables(
    :endpoint => node['endpoint']
  )
  mode 0664
end


# Create /etc/hosts configuration
template '/etc/hosts' do
  source 'hosts.erb'
  variables(
    :local => node['endpoint']['name'],
    :endpoints => node['endpoints']
  )
  mode 0664
end

# Get perfmon
remote_file '/perfmon-2.1b1.tgz' do
  source 'http://softlayer-ams.dl.sourceforge.net/project/perfmon/perfmon/2.1b1/perfmon-2.1b1.tgz'
  action :create_if_missing
end

# install NPM dependencies
bash 'run npm' do
  code <<-EOH
  cd /home/ubuntu/ldf-server
  mkdir summaries
  sudo npm install
  EOH
end

# Create upstart
template '/etc/init/ldfserver.conf' do
  source 'ldfserver.conf.erb'
  mode 0664
end

service "ldfserver" do
  supports [ :stop, :start ]
  action [ :enable, :start ]
end
