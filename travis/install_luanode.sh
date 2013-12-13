#!/bin/sh -ex
#
# install luanode dependencies
#
sudo luarocks install lunit
sudo apt-get install libboost-dev libboost-system-dev libboost-date-time-dev libboost-thread-dev liblua5.1-json

git clone --depth=1 --branch=master git://github.com/ignacio/LuaNode.git ~/luanode
cd ~/luanode/build
cmake -DBOOST_ROOT=/usr/lib ..
cmake --build .
sudo mv luanode /usr/bin/luanode
cd $TRAVIS_BUILD_DIR