export PATH=${PATH}:$HOME/.lua:$HOME/.local/bin:${TRAVIS_BUILD_DIR}/install/luarocks/bin
bash .travis/setup_lua.sh
eval `$HOME/.lua/luarocks path`
export LUA_DIR="$TRAVIS_BUILD_DIR/install/lua"
if [ "$LUANODE" == "true" ]; then
	bash .travis/setup_luanode.sh
fi;
