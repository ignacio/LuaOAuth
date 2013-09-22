local OAuth = require "OAuth"

module(..., lunit.testcase, package.seeall)

function test()
	local client = OAuth.new("anonymous", "anonymous", {
		RequestToken = "https://www.google.com/accounts/OAuthGetRequestToken",
		AuthorizeUser = {"https://www.google.com/accounts/OAuthAuthorizeToken", method = "GET"},
		AccessToken = "https://www.google.com/accounts/OAuthGetAccessToken"
	})

	local request_token = client:RequestToken({ oauth_callback = "oob", scope = "https://www.google.com/analytics/feeds/" })

	assert( not string.match(request_token.oauth_token, "%%") )
	print(request_token.oauth_token)

	local auth_url = client:BuildAuthorizationUrl()
	print("Test authorization at the following URL")
	print(auth_url)
	print(string.match(auth_url, "oauth_token=([^&]+)&"))
end
