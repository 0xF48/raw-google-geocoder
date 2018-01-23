## Keyless Google Geocoder
lost your google maps api key? no worries. this tiny module helps you parse and serialize queries straight from google.com/search. Since extracting data from google search results with regex is never perfect, the regex is not optimal. Even though it does supports a some latin letters, its best used with english addresses. Works great for western countries. Regex support for other countries/regions is welcome.
---
`npm install keyless-google-geocoder`
---

###tiny example
```coffeescript
request = require 'request'
geocoder = require 'keyless-google-geocoder'

request geocoder.serialize('RUA PAULINA ISABEL DE QUEIROS,, BANGU, SANTO ANDRE, 09210260, br'),(error,res,body)->
	address = geocoder.parse(body)
	console.log address
	###
	{ 
		addr: 'R. Paulina Isabel de Queirós - Bangú, Santo André - SP, Brazil',
		lat: -23.6418355,
		lon: -46.5262411
	}
	###
```