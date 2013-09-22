local OAuth = require "OAuth"

module(..., lunit.testcase, package.seeall)


local consumer_key = "key"
local consumer_secret = "secret"

function test()
	print("\nTest: term.ie\n")
	local client = OAuth.new(consumer_key, consumer_secret, {
		RequestToken = {"http://term.ie/oauth/example/request_token.php", method = "GET"},
		AccessToken = {"http://term.ie/oauth/example/access_token.php", method = "GET"}
	}, {
		UseAuthHeaders = false
	})
	print("Requesting token")
	local values, status, headers, response_line, response_body = client:RequestToken()
	if not values then
		print("Error requesting token:", status)
		for k,v in pairs(headers) do print(k,v) end
		print(response_line)
		print(response_body)
	end
	assert_table(values)
	if not values.oauth_token then
		print("Error requesting token:", status)
		for k,v in pairs(values) do print(k,v) end
		error("No oauth_token")
	end
	assert_equal("requestkey", values.oauth_token)
	assert_equal("requestsecret", values.oauth_token_secret)
	
	print("Retrieving access token")
	local values, status, headers, response_line, response_body = client:GetAccessToken()
	if not values then
		print("Error requesting token:", status)
		for k,v in pairs(headers) do print(k,v) end
		print(response_line)
		print(response_body)
	end
	assert_table(values)
	if not values.oauth_token then
		print("Error requesting token:", status)
		for k,v in pairs(values) do print(k,v) end
		error("No oauth_token")
	end
	assert_equal("accesskey", values.oauth_token)
	assert_equal("accesssecret", values.oauth_token_secret)
	
	print("Making authenticated call")
	local client = OAuth.new(consumer_key, consumer_secret, {
		RequestToken = {"http://term.ie/oauth/example/request_token.php", method = "GET"},
		AccessToken = {"http://term.ie/oauth/example/access_token.php", method = "GET"}
	}, {
		UseAuthHeaders = false,
		OAuthToken = "accesskey",
		OAuthTokenSecret = "accesssecret"
	})
	local response_code, response_headers, response_status_line, response_body = 
		client:PerformRequest("GET", "http://term.ie/oauth/example/echo_api.php", { foo="bar"})
	if response_code ~= 200 then
		print("Error requesting token:", response_code)
		for k,v in pairs(response_headers) do print(k,v) end
		print(response_status_line)
		print(response_body)
	end
	print(response_body)
	assert_equal("foo=bar", response_body)
end
