#/bin/bash

cd /opt/riak

# Activate Riak Control
for node in dev/dev*; do sed -i "s/riak_control = off/riak_control = on/g" $node/etc/riak.conf; done  

# Make Riak listen on all interfaces
for node in dev/dev*; do sed -i 's/127\.0/0\.0/g' $node/etc/riak.conf; done  
