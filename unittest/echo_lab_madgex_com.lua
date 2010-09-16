module(..., lunit.testcase, package.seeall)

-- see: http://echo.lab.madgex.com/
function test()
	local client = OAuth.new("key", "secret", {
		RequestToken = "http://echo.lab.madgex.com/request-token.ashx", 
		AccessToken = "http://echo.lab.madgex.com/access-token.ashx"
	})
	print("requesting token")
	local values = client:RequestToken()
	assert_table(values)
	assert_equal("requestkey", values.oauth_token)
	assert_equal("requestsecret", values.oauth_token_secret)
	--for k,v in pairs(values) do print(k,v) end
	
	print("getting access token")
	local values = client:GetAccessToken()
	
	assert_table(values)
	assert_equal("accesskey", values.oauth_token)
	assert_equal("accesssecret", values.oauth_token_secret)
	--for k,v in pairs(values) do print(k,v) end
	
	print("issuing test request")
	local code, headers, statusLine, body = client:PerformRequest("POST", "http://echo.lab.madgex.com/echo.ashx", {status = "Hello World From Lua (again)!" .. os.time()})
	assert_equal(200, code)
end
