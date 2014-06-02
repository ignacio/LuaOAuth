require "lunit"

package.path = "../src/?.lua;../src/?/init.lua;".. package.path

require "echo_lab_madgex_com"
--require "twitter"
require "termie"
require "google"
require "net_error"


local stats = lunit.main()
if stats.errors > 0 or stats.failed > 0 then
	os.exit(1)
end
