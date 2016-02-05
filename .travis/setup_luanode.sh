#!/bin/sh -ex
#
# install luanode dependencies
#
git clone --depth=1 --branch=master git://github.com/ignacio/LuaNode.git ~/luanode
cd ~/luanode/build
cmake -DBOOST_ROOT=/usr/lib ..
cmake --build .
ln -s ~/luanode/build/luanode $LUA_DIR/bin/luanode
luanode -v
