module(..., lunit.testcase, package.seeall)

local consumer_key = "my consumer key (you need to change this)"
local consumer_secret = "your consumer secret (you need to change this)"

function test()
	local client = OAuth.new(consumer_key, consumer_secret, {
		RequestToken = "http://api.twitter.com/oauth/request_token", 
		AuthorizeUser = {"https://api.twitter.com/oauth/authorize", method = "GET"},
		AccessToken = "http://api.twitter.com/oauth/access_token"
	})
	print("requesting token")
	local values = client:RequestToken()
	local auth_url = client:BuildAuthorizationUrl()
	print("Test authorization at the following URL")
	print(auth_url)
	assert_table(values)
	assert_string(values.oauth_token)
	assert_string(values.oauth_token_secret)
end
