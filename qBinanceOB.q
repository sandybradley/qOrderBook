\p 5010
\l tools.q

orderbook:([]ex:`$(); sym:`$(); price:`float$();size:`float$());

//pairInfo: .j.k .Q.hg ":https://api.binance.com/api/v1/exchangeInfo";
//BTCpairs: select from pairInfo[`symbols] where ((quoteAsset like "BTC") or baseAsset like "BTC") and status like "TRADING";
//BTCpairs: select from pairInfo[`symbols] where  (baseAsset like "BTC") and status like "TRADING";
//BTCpairs: select from BTCpairs where (quoteTradingSymbol in assetList) or baseTradingSymbol in assetList;
//pairs: 0N! lower BTCpairs[`symbol];

OBInfo: 0N! .j.k .Q.hg ":https://api.binance.com/api/v1/depth?symbol=BTCUSDT&limit=5000";
bidcount:count OBInfo`bids;
askcount:count OBInfo`asks;
biddata: flip OBInfo`bids;
askdata: flip OBInfo`asks;
bidprices:"F"$biddata[0];
bidsizes:"F"$biddata[1];
askprices:"F"$askdata[0];
asksizes:0.0-"F"$askdata[1];

`orderbook insert(ex:bidcount#`binance; sym:bidcount#`BTCUSDT; price:bidprices;size:bidsizes);
`orderbook insert(ex:askcount#`binance; sym:askcount#`BTCUSDT; price:askprices;size:asksizes);

anal: select price:string price,size:size from () xkey select sum size by 10.0 xbar price from orderbook;