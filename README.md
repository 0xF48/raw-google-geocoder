# Raw Google Geocoder
[![npm][npm]][npm-url]
[![tests][tests]][tests-url]

`npm i raw-google-geocoder`

Lost your google maps api key? No worries, this tiny module helps you parse and serialize queries straight from google.com/search, Works great with addresses in latin but regex support for other characters is welcome. Please note that **google may change their schema at any time**, so anyone is welcome to update the query/regex accordingly and send a pull request!

```javascript
var request = require('request')
var geocoder = require('raw-google-geocoder')

#contains common parameters such as the url that can passed straight to the request module.
var query_object = geocoder.serialize('RUA PAULINA ISABEL DE QUEIROS,, BANGU, SANTO ANDRE, 09210260, br')
request(query,function(error,res,body){
	console.log geocoder.parse(body)
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