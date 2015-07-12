#/bin/bash

export RIAK_HOME=/opt/riak

riakup(){
  for node in $RIAK_HOME/dev/dev*; do $node/bin/riak start; done
}
export -f riakup

riakstop(){
  for node in $RIAK_HOME/dev/dev*; do $node/bin/riak stop; done
}
export -f riakstop

riakping(){
  for node in $RIAK_HOME/dev/dev*; do $node/bin/riak ping; done
}
export -f riakping
