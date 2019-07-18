#!/bin/sh
wget https://nodejs.org/dist/v10.16.0/node-v10.16.0-linux-x64.tar.xz
yum -y install xz
xz -d node-v10.16.0-linux-x64.tar.xz && tar xvf node-v10.16.0-linux-x64.tar
mv node-v10.16.0-linux-x64 /usr/local/node
sudo ln -s /usr/local/node/bin/node /usr/local/sbin/
sudo ln -s /usr/local/node/bin/npm /usr/local/sbin/