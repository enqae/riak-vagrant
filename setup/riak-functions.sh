#/bin/bash

export RIAK_HOME=/opt/riak

riakstart(){
  for node in $RIAK_HOME/dev/dev*; do echo $node; $node/bin/riak start; done
}
export -f riakstart

riakstop(){
  for node in $RIAK_HOME/dev/dev*; do echo $node; $node/bin/riak stop; done
}
export -f riakstop

riakping(){
  for node in $RIAK_HOME/dev/dev*; do echo $node; $node/bin/riak ping; done
}
export -f riakping
