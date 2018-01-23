enc = require 'urlencode'

serialize = (address)->




	query = enc(address)
	url = "https://www.google.com/search?tbm=map&fp=1&authuser=0&hl=en&gl=us&q=#{query}&oq=#{query}&gs_l=maps.12..115i144k1.9659.41934.1.44751.12.12.0.0.0.0.154.154.0j1.11.0....0...1ac.1j2.64.maps..1.1.154.0...1.&tch=1&ech=1&psi=tq5nWp-hNcuotQWQqLaICQ.1516744376157.1" #copied straight from chrome inspector
	method: 'get'
	url: url
	gzip: true
	encoding: 'utf8'
	headers:
		'x-chrome-uma-enabled': 0 #do not report anything to google, the google AI will analyze you if this is set to 1. 
		'referer': 'https://www.google.com/' #pretend we are google
		#google AI monitors all requests that dont match a typical user profile and will block you if you dont pretend to be a human, so make sure your agent is always spoofed!
		'user-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'


parse = (body)->
	addr = lat = lon = addr1 = addr2 = null
	try
		[lat,lon] = body.match(/null,((?:\-|\+)?\d?\d?\d\.\d+\,(?:\-|\+)?\d\d?\d?.\d+)]/)[1].split(',')
		lat = Number(lat)
		lon = Number(lon)
	catch e
		console.error 'could not parse lat/lon'
	try
		match = body.match(/,\\"([A-Za-z\u00C0-\u00FF\u2000-\u206F\u2E00-\u2E7F#\-,. \d]+ [A-Za-z\u00C0-\u00FF\u2000-\u206F\u2E00-\u2E7F#,. \-\d]+)\\"/g)
		[addr1,addr2] = match
		if !addr2 || (addr1 && addr1.length > addr2.length)
			addr = addr1
		else
			addr = addr2
		addr = addr.match(/([A-Za-z\u00C0-\u00FF\u2000-\u206F\u2E00-\u2E7F#\-,. \d]+)/g)[1]
	catch e
		console.error 'could not parse address'
	
	return {addr,lat,lon}


module.exports.parse = parse
module.exports.serialize = serialize