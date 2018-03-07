# Raw Google Geocoder
[![npm][npm]][npm-url]
[![tests][tests]][tests-url]

`npm i raw-google-geocoder`

Lost your google maps api key? No worries, this tiny module helps you parse and serialize queries straight from google.com/search.
Works good with addresses in latin.

---
If the build is starting to fail, that means either one of the addresses has been updated or the **the schema has changed** and the query/regex needs to be updated.

```javascript
var request = require('request')
var geocoder = require('raw-google-geocoder')

//object w/ url passed to the request module.
var use_https = false
var query_object = geocoder.serialize('RUA PAULINA ISABEL DE QUEIROS,, BANGU, SANTO ANDRE, 09210260, br',use_https)


//make a request with request module
request(query,function(error,res,body){

	//parse the body and extract address and gps coordinates, make sure to catch any errors for bad addresses
	try{
		console.log geocoder.parse(body)
	}catch(error){
		console.error error
	}
	/*
	addr: 'R. Paulina Isabel de Queirós - Bangú, Santo André - SP, Brazil',
	lat: -23.6418355,
	lon: -46.5262411
	*/	
})
```

[tests]: https://img.shields.io/travis/arxii/raw-google-geocoder/master.svg?style=flat-square
[tests-url]: https://travis-ci.org/arxii/raw-google-geocoder

[npm]: https://img.shields.io/npm/v/raw-google-geocoder.svg?style=flat-square
[npm-url]: https://npmjs.com/raw-google-geocoder