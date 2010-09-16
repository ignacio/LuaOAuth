module(..., lunit.testcase, package.seeall)

function test()
	local client = OAuth.new("DohGwPF73BAT1l0tgyQcg", "ZOrPYJV1DjuVCHr4tZLY5ifU9BWxkRrB9PQtKsEeY", {
		RequestToken = "http://api.twitter.com/oauth/request_token", 
		AccessToken = "http://api.twitter.com/oauth/access_token"
	})
	print("requesting token")
	local values = client:RequestToken()
	assert_table(values)
	assert_string(values.oauth_token)
	assert_string(values.oauth_token_secret)
end
