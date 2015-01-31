%w(
curl
vim
git
build-essential
openssl
libssl-dev
default-jre
).each { | pkg | package pkg }

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
git '/home/ubuntu/Fedbench 3.0/federated-ldf' do
  repository 'http://git.mmlab.be/mvdrsand/discoveryclient.git'
  revision 'Federated-progressive'
  action :sync
end

bash 'Run npm' do
  code <<-EOH
  cd /home/ubuntu/FedBench\ 3.0/federated-ldf
  npm install
  EOH
end

node['endpoints'].each{ |endpt|
  # Create JSON configuration
  template '/home/ubuntu/FedBench\ 3.0/federated-ldf/config-fedbench.json' do
    source "config-fedbench-#{endpt['name']}.json.erb"
    variables(
      :endpoint => endpt
    )
    mode 0664
  end
}
