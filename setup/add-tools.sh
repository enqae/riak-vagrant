#/bin/bash

# Copy file with functions and init-cluster to "vagrant" user dir
FUNCTIONS_FILE=/home/vagrant/riak-functions.sh
cp /vagrant/setup/riak-functions.sh $FUNCTIONS_FILE 
chown vagrant:vagrant $FUNCTIONS_FILE 
chmod 700 $FUNCTIONS_FILE

RIAK_INIT=/home/vagrant/riak-init.sh
cp /vagrant/setup/riak-init.sh $RIAK_INIT 
chown vagrant:vagrant $RIAK_INIT 
chmod 700 $RIAK_INIT

# Add it to .bashrc
sed -i -e "\$a#RIAK TOOLS" /home/vagrant/.bashrc
sed -i -e "\$asource riak-functions.sh" /home/vagrant/.bashrc

