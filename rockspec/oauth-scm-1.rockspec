package = "OAuth"
version = "scm-1"
source = {
	url = "git://github.com/ignacio/LuaOAuth.git",
	branch = "master"
}
description = {
	summary = "Lua OAuth, an OAuth client library.",
	detailed = [[
		Lua client for OAuth 1.0 enabled servers.
	]],
	license = "MIT/X11",
	homepage = "http://github.com/ignacio/LuaOAuth"
}
dependencies = {
	"lua >= 5.1",
	"luasocket",
	"luasec",
	"luacrypto",
	"lbase64"
}

external_dependencies = {

}
build = {
	type = "none",
	modules = {
		OAuth = "src/OAuth.lua"
	}
}
