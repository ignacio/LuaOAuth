local pairs, table, tostring = pairs, table, tostring
local Url, Qs
local isLuaNode

if process then
	Url = require "luanode.url"
	Qs = require "luanode.querystring"
	isLuaNode = true
else
	Url = require "socket.url"
end

module((...))

--
-- Encodes the key-value pairs of a table according the application/x-www-form-urlencoded content type.
url_encode_arguments = (isLuaNode and Qs.url_encode_arguments) or function(arguments)
	local body = {}
	for k,v in pairs(arguments) do
		body[#body + 1] = Url.escape(tostring(k)) .. "=" .. Url.escape(tostring(v))
	end
	return table.concat(body, "&")
end
