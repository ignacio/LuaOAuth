local OAuth = require "OAuth"

module(..., lunit.testcase, package.seeall)


local consumer_key = "key"
local consumer_secret = "secret"

function test()
	print("term.ie")
	local client = OAuth.new(consumer_key, consumer_secret, {
		RequestToken = {"http://term.ie/oauth/example/request_token.php", method = "GET"},
		AccessToken = {"http://term.ie/oauth/example/access_token.php", method = "GET"}
	}, {
		UseAuthHeaders = false
	})
	print("Requesting token")
	client:RequestToken(function(err, values)
		assert_nil(err)

		assert_table(values)
		assert_equal("requestkey", values.oauth_token)
		assert_equal("requestsecret", values.oauth_token_secret)
		
		print("Retrieving access token")
		client:GetAccessToken(function(err, values)
			assert_nil(err)

			assert_table(values)
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
			
			client:PerformRequest("GET", "http://term.ie/oauth/example/echo_api.php", { foo="bar"}, 
				function(err, response_code, response_headers, response_status_line, response_body)
					assert_nil(err)
					
					if response_code ~= 200 then
						print("Error requesting token:", response_code)
						for k,v in pairs(response_headers) do print(k,v) end
						print(response_status_line)
						print(response_body)
					end
					print(response_body)
					assert_equal("foo=bar", response_body)
			end)
		end)
	end)
	
	process:loop()
end


