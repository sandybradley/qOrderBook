\p 5010
\l ws3.q
\l tools.q

//orderbook:([]ex:`$(); sym:`$(); price:`float$();size:`float$());

//pairInfo: .j.k .Q.hg ":https://api.binance.com/api/v1/exchangeInfo";
//BTCpairs: select from pairInfo[`symbols] where ((quoteAsset like "BTC") or baseAsset like "BTC") and status like "TRADING";
//BTCpairs: select from pairInfo[`symbols] where  (baseAsset like "BTC") and status like "TRADING";
//BTCpairs: select from BTCpairs where (quoteTradingSymbol in assetList) or baseTradingSymbol in assetList;
//pairs: 0N! lower BTCpairs[`symbol];

OBInfo: 0N! .j.k .Q.hg ":https://api-pub.bitfinex.com/v2/book/tBTCUSD/P3?len=100";
bookcount:count OBInfo;
bookdata: flip OBInfo;
bookprices:bookdata[0];
booksizes:bookdata[2];

`orderbook insert(ex:bookcount#`bitfinex; sym:bookcount#`BTCUSD; price:bookprices;size:booksizes);

anal: select price:string price,size:size from () xkey select sum size by 10.0 xbar price from orderbook;