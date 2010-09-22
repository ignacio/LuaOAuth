require "luarocks.require"
require "lunit"

local OAuth = require "OAuth"
local console = require "lunit-console"

require "echo_lab_madgex_com"
--require "twitter"
require "termie"

-- eventos posibles:
-- begin, done, fail, err, run, pass

lunit.setrunner({
	fail = function(...)
		print(...)
	end,
	err = function(...)
		print(...)
	end,
})

console.begin()
lunit.run()
console.done()