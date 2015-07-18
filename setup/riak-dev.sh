#!/bin/bash

mkdir -p /home/vagrant/tmp

TMP_RIAK=/home/vagrant/tmp

# Depends on the follwoing version of Erlang from Basho
ERLANG_VERSION=otp_src_R16B02-basho8.tar.gz
ERLANG_UNTARRED=OTP_R16B02_basho8

if [ "$#" -ne 3 ]; then
    echo "Usage: riak-dev.sh RIAK_MAJOR RIAK_MINOR RIAK PATCH"
    echo "ie.: riak-dev.sh 2 1 1"
    exit 1
fi
 
RIAK_MAJOR=$1
RIAK_MINOR=$2
RIAK_PATCH=$3

# Ubuntu and dev tools
sudo apt-get -y update
sudo apt-get -y install git
sudo apt-get -y install build-essential autoconf libncurses5-dev openssl libssl-dev fop xsltproc unixodbc-dev
sudo apt-get -y install libwxbase2.8 libwxgtk2.8-dev libqt4-opengl-dev
sudo apt-get install -y openjdk-7-jdk

# Erlang
pushd $TMP_RIAK
wget http://s3.amazonaws.com/downloads.basho.com/erlang/$ERLANG_VERSION
tar zxvf $ERLANG_VERSION
pushd $ERLANG_UNTARRED/
export ERL_TOP=$(pwd)
./otp_build autoconf 
./configure && make && sudo make install
popd
popd

# Set the "limits" for Riak
sudo sed -i -e "\$afs.file-max = 65536" /etc/sysctl.conf
sudo sed -i -e "\$a* soft nofile 65536" /etc/security/limits.conf 
sudo sed -i -e "\$a* hard nofile 65536" /etc/security/limits.conf 


# Riak Sources
pushd $TMP_RIAK
sudo apt-get install -y libc6-dev-i386 libpam0g-dev
RIAK_BASE_VERSION=$RIAK_MAJOR.$RIAK_MINOR
RIAK_FULL_VERSION=$RIAK_BASE_VERSION.$RIAK_PATCH
RIAK_DIR=riak-$RIAK_FULL_VERSION
wget http://s3.amazonaws.com/downloads.basho.com/riak/$RIAK_BASE_VERSION/$RIAK_FULL_VERSION/$RIAK_DIR.tar.gz
tar zxvf $RIAK_DIR.tar.gz
pushd $RIAK_DIR
make locked-deps
make rel

# Prepare 5 nodes for development
make devrel DEVNODES=5

# Adjust permissions for "dev"
sudo chown -R vagrant:vagrant dev

popd

# put riak on opt
sudo mv $RIAK_DIR /opt/riak

popd
