module(..., lunit.testcase, package.seeall)

local OAuth = require "OAuth"

local consumer_key = "<your consumer key>"
local consumer_secret = "<your consumer secret>"

---
-- Teste requesting a token from Twitter and build the authorization url.
--
function testAuthorize()
	local OAuth = require "OAuth"
	
	local client = OAuth.new(consumer_key, consumer_secret, {
		RequestToken = "https://api.twitter.com/oauth/request_token",
		AuthorizeUser = {"https://api.twitter.com/oauth/authorize", method = "GET"},
		AccessToken = "https://api.twitter.com/oauth/access_token"
	})

	print("requesting token")
	local values = client:RequestToken()
	assert_table(values)
	assert_string(values.oauth_token)
	assert_string(values.oauth_token_secret)
	--for k,v in pairs(values) do print(k,v) end
	
	local auth_url = client:BuildAuthorizationUrl()
	assert_string(auth_url)
	
	print("Test authorization at the following URL: " .. auth_url)
end


---
-- Uses the update_with_media Twitter endpoint to test a POST request with multipart/form-data encoding.
--
function testMultipartPost()

	-- helper
	local function read_image()
		local f = assert(io.open([[test_twitter_multipart.jpg]], "rb"))
		local image_data = f:read("*a")
		f:close()
		return image_data
	end

	local oauth_token = "<a valid oauth token>"
	local oauth_token_secret = "<and its corresponding token secret>"

	local client = OAuth.new(consumer_key, consumer_secret, {
		RequestToken = "https://api.twitter.com/oauth/request_token",
		AuthorizeUser = {"https://api.twitter.com/oauth/authorize", method = "GET"},
		AccessToken = "https://api.twitter.com/oauth/access_token"
	}, {
		OAuthToken = oauth_token,
		OAuthTokenSecret = oauth_token_secret
	})

	local helpers = require "OAuth.helpers"

	local req = helpers.multipart.Request{
		status = "Hello World From Lua!" .. os.time(),
		["media[]"] = {
			filename = "@test_multipart.jpg",
			data = read_image()
		}
	}

	local response_code, response_headers, response_status_line, response_body =
		client:PerformRequest("POST", "https://api.twitter.com/1.1/statuses/update_with_media.json", req.body, req.headers)
	assert_equal(200, response_code)
end
