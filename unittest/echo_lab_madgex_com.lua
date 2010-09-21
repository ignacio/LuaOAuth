module(..., lunit.testcase, package.seeall)

-- see: http://echo.lab.madgex.com/
function test()
	print("echo.lab.madgex.com")
	local client = OAuth.new("key", "secret", {
		RequestToken = "http://echo.lab.madgex.com/request-token.ashx", 
		AccessToken = "http://echo.lab.madgex.com/access-token.ashx"
	})
	print("Requesting token")
	local values, status, headers, response_line, response_body = client:RequestToken()
	if not values then
		print(status)
		for k,v in pairs(headers) do print(k,v) end
		print(response_line)
		print(response_body)
	end
	assert_table(values)
	assert_equal("requestkey", values.oauth_token)
	assert_equal("requestsecret", values.oauth_token_secret)
	
	print("Retrieving access token")
	local values = client:GetAccessToken()
	
	assert_table(values)
	assert_equal("accesskey", values.oauth_token)
	assert_equal("accesssecret", values.oauth_token_secret)
	
	print("Making authenticated call")
	local client = OAuth.new("key", "secret", {
		RequestToken = "http://echo.lab.madgex.com/request-token.ashx", 
		AccessToken = "http://echo.lab.madgex.com/access-token.ashx"
	})
	client:SetToken("accesskey")
	client:SetTokenSecret("accesssecret")
	local response_code, response_headers, response_status_line, response_body = client:PerformRequest("GET", "http://echo.lab.madgex.com/echo.ashx", 
																		{foo = "bar"}
	)
	if response_code ~= 200 then
		print("Error requesting token:", response_code)
		for k,v in pairs(response_headers) do print(k,v) end
		print(response_status_line)
		print(response_body)
	end
	print(response_body)
	assert_equal("foo=bar", response_body)
end
