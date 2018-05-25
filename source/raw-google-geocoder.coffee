enc = require 'urlencode'

# serialize address as a query
serialize = (address,use_https)->
	query = enc(address)
	if use_https
		protocol = 'https'
	else
		protocol = 'http'
	url = "https://www.google.com/search?tbm=map&q=#{query}&tch=0"
	method: 'get'
	url: url
	gzip: true
	encoding: 'utf8'
	headers:
		'x-chrome-uma-enabled': 0 #do not report anything to google, the google AI will analyze you if this is set to 1. 
		'accept':'*/*'
		'referer': 'https://www.google.com/' #pretend we are google
		#google AI monitors all requests that dont match a typical user profile and will block you if you dont pretend to be a human, so make sure your agent is always spoofed!
		'user-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.167 Safari/537.36'

# parse the google response body and try and choose the right address.
parse = (body)->
	addr = lat = lon = addr1 = addr2 = null

	match_addr = body.match(/null,((?:\-|\+)?\d?\d?\d\.\d+\,(?:\-|\+)?\d\d?\d?.\d+)]/)
	if !match_addr
		throw new Error 'RawGGeocoderError: lat/lon could not be matched.'+'\n'+body
	[lat,lon] = match_addr[1].split(',')
	lat = Number(lat)
	lon = Number(lon)
	
	try
		match = body.match(/,\\"([A-Za-z\u00C0-\u00FF\u2000-\u206F\u2E00-\u2E7F#\-,. \d]+, [A-Za-z\u00C0-\u00FF\u2000-\u206F\u2E00-\u2E7F#,. \-\d]+)\\"/g)
		pickone = null
		for addr in match
			if !pickone || addr.length > pickone.length
				pickone = addr

		addr = pickone.match(/([A-Za-z\u00C0-\u00FF\u2000-\u206F\u2E00-\u2E7F#\-,. \d]+)/g)[1]
	catch e
		throw new Error 'RawGGeocoderError: could not parse address'
	
	return {addr,lat,lon}


module.exports.parse = parse
module.exports.serialize = serialize