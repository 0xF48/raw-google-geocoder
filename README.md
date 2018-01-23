### Keyless Google Geocoder

lost your google maps api key? no worries. this tiny module helps you parse and serialize queries straight from google.com/search. Since extracting data from google search results with regex is never perfect, the regex is not optimal. Even though it does supports a some latin letters, its best used with english addresses. Works great for western countries. Regex support for other countries/regions is welcome. If you use this, please note that google may change their schema at any time, so update the regex accordingly and send a pull request!


`npm install keyless-google-geocoder`


## tiny example
```javascript
var request = require('request')
var geocoder = require('keyless-google-geocoder')
query = geocoder.serialize('RUA PAULINA ISABEL DE QUEIROS,, BANGU, SANTO ANDRE, 09210260, br')
request(query,function(error,res,body){
	console.log geocoder.parse(body)
	/*
	addr: 'R. Paulina Isabel de Queirós - Bangú, Santo André - SP, Brazil',
	lat: -23.6418355,
	lon: -46.5262411
	*/	
})
```