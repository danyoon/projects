Expedia.setup do |config|
	config.cid = 55505 # your cid once you go live.
	config.api_key = ENV["EXPEDIA_ID"] || "f2zk2fhzen9e9pv3nkm73fc7"
	config.shared_secret = ENV["EXPEDIA_SECRET"] || "DTAfJ7XS"
	config.locale = 'en_US' # For Example 'de_DE'. Default is 'en_US'
	config.currency_code = 'USD' # For Example 'EUR'. Default is 'USD'
	config.minor_rev = 13 # between 4-19 as of Dec 2012. Default is 4. 19 being latest
end
