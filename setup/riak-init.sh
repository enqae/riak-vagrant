#/bin/bash

# Init cluster for first time
cd /opt/riak/dev

# Start nodes
for node in dev*; do $node/bin/riak start; done

# Check if cluster was already formed
# ...

# Join, Plan and Commit
dev2/bin/riak-admin cluster join dev1@0.0.0.0
for n in {3..5}; do dev$n/bin/riak-admin cluster join dev1@0.0.0.0; done

dev1/bin/riak-admin cluster plan

dev2/bin/riak-admin cluster commit

# Stop Cluster
for node in dev*; do $node/bin/riak stop; done
