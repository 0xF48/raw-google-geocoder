// Generated by CoffeeScript 2.1.1
var FuzzySet, addr, fuzzy_set, i, j, kgg, len, p, parsed, raw, request, test, test_addr;

kgg = require('./index.js');

request = require('request');

test = require('tape');

p = require('bluebird');

FuzzySet = require('fuzzyset.js');

raw = ["L15 oHH, GB", "300 Yarmouth Street #323, Norfolk, VA, 23510, us", "Gulf Shores, AL, 36542, us", "KA111ly, GB", "N/A, Jersey City, NJ, 07097, us", "SL2 5FZ, GB", "Frankfort, IL, 60423, us", "5528 North Central Avenue, Chicago, IL, 60630, us", "A-107, Annu Apartment, white field, bangalore, 560066, in", "1250 north tomcat ct, virginia beach, VA, 23454, us", "Chessington, KT19 8FS, GB", "5581 Edgeberry Drive, Murray, UT, 84123, us", "MK40 4LR, GB", "8726 S WOOD CREEK DR, #5, OAK CREEK, WI, 53154, us", "362 Haydn Ct, Wheaton, IL, 60189, us", "RUA PAULINA ISABEL DE QUEIROS,, BANGU, SANTO ANDRE, 09210260, br", "jonesboro, GA, 30238, us"];

parsed = [
  {
    addr: 'Liscard Rd, Liverpool L15 0HH, UK',
    lat: 53.3984265,
    lon: -2.9372757999999997
  },
  {
    addr: '300 Yarmouth St #323, Norfolk, VA 23510',
    lat: 36.851300699999996,
    lon: -76.2935181
  },
  {
    addr: 'Gulf Shores, Alabama',
    lat: 30.246036099999998,
    lon: -87.70081929999999
  },
  {
    addr: 'KA11 1LY, Whitehope Green, Bourtreehill North, Irvine, UK',
    lat: 55.620890499999994,
    lon: -4.6346871
  },
  {
    addr: 'Jersey City, NJ 07097',
    lat: 40.7548065,
    lon: -74.06819879999999
  },
  {
    addr: 'SL2 5FZ, Slough, UK',
    lat: 51.5121499,
    lon: -0.5893836
  },
  {
    addr: 'Frankfort, IL 60423',
    lat: 41.480981899999996,
    lon: -87.8353278
  },
  {
    addr: '5528 N Central Ave, Chicago, IL 60630',
    lat: 41.9819786,
    lon: -87.7687093
  },
  {
    addr: 'Ramamurthy Nagar, Dooravani Nagar, Dooravani Nagar, Manjunatha Layout, Ramamurthy Nagar, Bengaluru, Karnataka 560016, India',
    lat: 13.012351899999999,
    lon: 77.679322
  },
  {
    addr: '1250 N Tomcat Ct, Virginia Beach, VA 23454',
    lat: 36.7972982,
    lon: -76.0144492
  },
  {
    addr: 'KT19 8FS, Epsom, UK',
    lat: 51.3493333,
    lon: -0.2685448
  },
  {
    addr: '5581 S Edgeberry Dr, Murray, UT 84123',
    lat: 40.6497445,
    lon: -111.9279418
  },
  {
    addr: 'MK40 4LR, Cromwell Rd, Bedford, UK',
    lat: 52.1334783,
    lon: -0.4828512
  },
  {
    addr: '8726 S Wood Creek Dr #5, Oak Creek, WI 53154',
    lat: 42.8861764,
    lon: -87.9201531
  },
  {
    addr: 'Allo Blueprint Service, 362 Haydn Ct, Wheaton, IL 60189',
    lat: 41.831451,
    lon: -88.109566
  },
  {
    addr: 'R. Paulina Isabel de Queirós - Bangú, Santo André - SP, Brazil',
    lat: -23.6409168,
    lon: -46.526493099999996
  },
  {
    addr: 'Jonesboro, Georgia',
    lat: 33.5215013,
    lon: -84.3538128
  }
];

fuzzy_set = FuzzySet(parsed.map(function(addr) {
  return addr.addr;
}));

// p.map(raw, (addr)->
// 	new Promise (resolve,reject)->
// 		request kgg.serialize(addr),(error,res,body)->
// 			resolve(kgg.parse(body))
// ,concurrency:1).then (parsed)->
// 	console.log parsed

// request kgg.serialize('Atlanta, GA'),(error,res,body)->
// 	r = kgg.parse(body)
test_addr = function(i) {
  return test(raw[i], function(t) {
    return request(kgg.serialize(raw[i]), function(error, res, body) {
      var addr_match, r;
      r = kgg.parse(body);
      addr_match = fuzzy_set.get(r.addr, null);
      if (addr_match !== null && addr_match[0][0] > 0.5) {
        t.ok(r.addr, 'score: ' + Math.round(addr_match[0][0] * 100) / 100 + ' | ' + r.addr + ' ~= ' + parsed[i].addr);
      } else {
        t.notOk(r.addr, r.addr + ' ~!= ' + parsed[i].addr);
      }
      t.equal(Math.round(r.lat * 100) / 100, Math.round(parsed[i].lat * 100) / 100, Math.round(r.lat * 100) / 100 + ' ~== ' + Math.round(parsed[i].lat * 100) / 100);
      t.equal(Math.round(r.lon * 100) / 100, Math.round(parsed[i].lon * 100) / 100, Math.round(r.lat * 100) / 100 + ' ~== ' + Math.round(parsed[i].lat * 100) / 100);
      return t.end();
    });
  });
};

for (i = j = 0, len = raw.length; j < len; i = ++j) {
  addr = raw[i];
  test_addr(i);
}
