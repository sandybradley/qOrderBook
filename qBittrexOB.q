\p 5010
\l tools.q
\l reQ/req.q

//orderbook:([]ex:`$(); sym:`$(); price:`float$();size:`float$());

//pairInfo: .j.k .Q.hg ":https://api.binance.com/api/v1/exchangeInfo";
//BTCpairs: select from pairInfo[`symbols] where ((quoteAsset like "BTC") or baseAsset like "BTC") and status like "TRADING";
//BTCpairs: select from pairInfo[`symbols] where  (baseAsset like "BTC") and status like "TRADING";
//BTCpairs: select from BTCpairs where (quoteTradingSymbol in assetList) or baseTradingSymbol in assetList;
//pairs: 0N! lower BTCpairs[`symbol];

OBInfo: 0N! .reqnew.g ":https://api.bittrex.com/v3/markets/BTC-USDT/orderbook?depth=500";

biddata: OBInfo`bid;
askdata: OBInfo`ask;
bidprices:"F"$biddata[`rate];
bidsizes:"F"$biddata[`quantity];
askprices:"F"$askdata[`rate];
asksizes:0.0-"F"$askdata[`quantity];
bidcount:count bidsizes;
askcount:count asksizes;

`orderbook insert(ex:bidcount#`bittrex; sym:bidcount#`BTCUSDT; price:bidprices;size:bidsizes);
`orderbook insert(ex:askcount#`bittrex; sym:askcount#`BTCUSDT; price:askprices;size:asksizes);

anal: select price:string price,size:size from () xkey select sum size by 100.0 xbar price from orderbook where price within (4000;20000);