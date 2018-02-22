rgg = require './raw-google-geocoder.coffee'
addr = "L15 oHH, GB"
request = require 'request'
raw = [
	"300 Yarmouth Street #323, Norfolk, VA, 23510, us",
	"Gulf Shores, AL, 36542, us",
	"KA111ly, GB",
	"SL2 5FZ, GB",
	"Frankfort, IL, 60423, us",
	"5528 North Central Avenue, Chicago, IL, 60630, us",
	"A-107, Annu Apartment, white field, bangalore, 560066, in",
	"1250 north tomcat ct, virginia beach, VA, 23454, us",
	"Chessington, KT19 8FS, GB",
	"5581 Edgeberry Drive, Murray, UT, 84123, us",
	"MK40 4LR, GB",
	"8726 S WOOD CREEK DR, #5, OAK CREEK, WI, 53154, us",
	"362 Haydn Ct, Wheaton, IL, 60189, us",
	"RUA PAULINA ISABEL DE QUEIROS,, BANGU, SANTO ANDRE, 09210260, br",
	"jonesboro, GA, 30238, us"
]


test_addr = (addr)->
	opt = rgg.serialize(addr)
	console.log '\n---------\nSERIALIZED OBJECT:\n'+JSON.stringify(opt,null,3)+'\n---------\n'
	request opt,(error,res,body)->
		console.log '\n---------\nBODY:\n'+String(body)+'\n---------\n'
		r = rgg.parse(body)
		console.log '\n---------\nPARSED:\n'+JSON.stringify(r,null,3)+'\n---------\n'


test_addr(raw[0])