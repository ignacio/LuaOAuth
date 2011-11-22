local OAuth = require "OAuth"

module(..., lunit.testcase, package.seeall)

function test()
	local client = OAuth.new("anonymous", "anonymous", {
		RequestToken = "http://127.0.0.1:12345/foo",
		AuthorizeUser = {"http://127.0.0.1:12345/bar", method = "GET"},
		AccessToken = "http://127.0.0.1:12345/baz"
	})

	local ok, err_msg = client:RequestToken(function(values, status, headers, response_line, response_body)
		assert(not values)
		assert_equal(process.constants.ECONNREFUSED, headers)
	end)
	
	process:loop()
end
