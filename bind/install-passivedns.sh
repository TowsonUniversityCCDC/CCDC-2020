#!/bin/sh

# install passivedns on ubuntu machines
apt-get install -y git-core binutils-dev libldns1 libldns-dev libpcap-dev libjansson-dev autoconf

git clone git://github.com/gamelinux/passivedns.git
cd passivedns/
autoreconf --install
./configure --enable-json
make

# start passivedns with JSON logging as a daemon
# log will be in /var/log/passivedns.log
./src/passivedns -jD

