
#
# dont't prompt for host key verfication (if any)
cookbook_file '/home/ubuntu/.ssh/config' do
  mode '0600'
  source 'config'
end

cookbook_file '/home/ubuntu/.ssh/aws.pub' do
  mode '0400'
  source 'aws.pub'
end

bash 'Add public key to authorized' do
  code 'sudo cat /home/ubuntu/.ssh/aws.pub >> /home/ubuntu/.ssh/authorized_keys'
end

# execute 'apt-get update'
# package 'python-software-properties'
#
# # install the software we need
# %w(
# curl
# vim
# git
# build-essential
# openssl
# libssl-dev
# ).each { | pkg | package pkg }

cookbook_file '/home/ubuntu/.bash_profile' do
  source '.bash_profile'
end

bash 'Install node and npm' do
  code <<-EOH
  #curl -sL https://deb.nodesource.com/setup | sudo bash -
  sudo apt-get install -y nodejs
  npm install -g node-gyp # Install the "node-gyp" globally.
  cd ~
  npm update # Update your personal npm local repository again.
  npm -g install forever
  EOH
end

# install the nodejs server
git '/home/ubuntu/ldf-server' do
  repository 'https://github.com/LinkedDataFragments/Server.js.git'
  revision 'master'
  action :sync
end

# Create JSON configuration
template '/home/ubuntu/ldf-server/config.json' do
  source 'config.json.erb'
  variables(
    :endpoint => node['endpoint'],
    :summary => node['ldf']['summary'],
    :explore => node['ldf']['explore']
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

# Create nginx configuration
cookbook_file '/etc/nginx/mime.types' do
  source 'mime.types'
  mode 0664
end

cookbook_file '/etc/nginx/nginx.conf' do
  source 'nginx.conf'
  mode 0664
end

cookbook_file '/etc/rc.local' do
  source 'startup.sh'
  mode 0664
end

bash 'run startup' do
  code <<-EOH
  test -d /mnt/tmp             || mkdir -m 1777 /mnt/tmp
  test -d /mnt/tmp/nginx       || mkdir -m 1777 -p /mnt/tmp/nginx
  test -d /mnt/tmp/cache/nginx || mkdir -m 1777 -p /mnt/tmp/cache/nginx
  test -d /mnt/log/nginx       || mkdir -m 1777 -p /mnt/log/nginx
  EOH
end

link '/etc/nginx/sites-enabled/default' do
  action :delete
end

cookbook_file "/etc/nginx/sites-enabled/default.conf" do
  source 'nginx-site.conf'
  mode 0664
end

# Get perfmon
# remote_file '/perfmon-2.1b1.tgz' do
#   source 'http://softlayer-ams.dl.sourceforge.net/project/perfmon/perfmon/2.1b1/perfmon-2.1b1.tgz'
#   action :create_if_missing
# end

# install NPM dependencies
bash 'run npm' do
  code <<-EOH
  cd /home/ubuntu/ldf-server
  sudo git pull
  mkdir summaries
  sudo npm install
  sudo forever start -o out.log  -e /vagrant/#{node['endpoint']['name']}.csv  ./bin/ldf-server ./config.json 4000 1
  EOH
end

service 'nginx' do
  action [ :restart ]
end
