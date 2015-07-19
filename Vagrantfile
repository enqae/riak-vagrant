# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  # Access to cluster nodes 
  # HTTP Access
  config.vm.network "forwarded_port", guest: 10018, host: 10018
  config.vm.network "forwarded_port", guest: 10028, host: 10028
  config.vm.network "forwarded_port", guest: 10038, host: 10038
  config.vm.network "forwarded_port", guest: 10048, host: 10048
  config.vm.network "forwarded_port", guest: 10058, host: 10058

  # PB Access
  config.vm.network "forwarded_port", guest: 10017, host: 10017
  config.vm.network "forwarded_port", guest: 10027, host: 10027
  config.vm.network "forwarded_port", guest: 10037, host: 10037
  config.vm.network "forwarded_port", guest: 10047, host: 10047
  config.vm.network "forwarded_port", guest: 10057, host: 10057

  config.vm.provider :virtualbox do |vb|
     vb.memory = "1024"
     vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
     vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  # Install Riak
  # Remember the installations depends on the Erlang Version (look at the script)
  config.vm.provision "shell" do |s|
    s.path = "setup/riak-dev.sh"
    s.args = "2 1 1"
  end
  
  # Config cluster to listen on all interfaces
  config.vm.provision "shell" do |s|
    s.path = "setup/config-cluster.sh"
  end

  # Add init scripts and some tools 
  config.vm.provision "shell" do |s|
    s.path = "setup/add-tools.sh"
  end

  # Init the cluster 
  config.vm.provision "shell" do |s|
    s.path = "setup/riak-init.sh"
    s.privileged = false
  end
end
