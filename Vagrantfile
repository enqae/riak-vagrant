# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  # Access to cluster nodes 
  config.vm.network "forwarded_port", guest: 10018, host: 10018
  config.vm.network "forwarded_port", guest: 10028, host: 10028
  config.vm.network "forwarded_port", guest: 10038, host: 10038
  config.vm.network "forwarded_port", guest: 10048, host: 10048
  config.vm.network "forwarded_port", guest: 10058, host: 10058

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

  # Exposed and init the Cluster 
  config.vm.provision "shell" do |s|
    s.path = "setup/config-cluster.sh"
  end

  # Add some tools 
  config.vm.provision "shell" do |s|
    s.path = "setup/add-tools.sh"
  end
end
