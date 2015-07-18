#/bin/bash

# Copy file with functions to "vagrant" user dir
RIAK_FUNCTIONS=/home/vagrant/riak-functions.sh
cp /vagrant/setup/riak-functions.sh $RIAK_FUNCTIONS
chown vagrant:vagrant $RIAK_FUNCTIONS
chmod 700 $RIAK_FUNCTIONS

# Add functions to .bashrc
sed -i -e "\$a#RIAK TOOLS" /home/vagrant/.bashrc
sed -i -e "\$asource riak-functions.sh" /home/vagrant/.bashrc

# Copy init-cluster to "vagrant" user dir
RIAK_INIT=/home/vagrant/riak-init.sh
cp /vagrant/setup/riak-init.sh $RIAK_INIT 
chown vagrant:vagrant $RIAK_INIT 
chmod 700 $RIAK_INIT


