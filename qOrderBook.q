// q script to take a snapshot of 10 biggest trusted spot exchanges for Bitcoin / USD market

\p 5010
\l reQ/req.q

orderbook:([]ex:`$(); sym:`$(); price:`float$();size:`float$());
// Binance
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
// Kraken
OBInfo: 0N! .reqnew.g ":https://api.cryptowat.ch/markets/kraken/btcusd/orderbook";

biddata: flip OBInfo[`result][`bids];
askdata: flip OBInfo[`result][`asks];
bidprices:biddata[0];
bidsizes:biddata[1];
askprices:askdata[0];
asksizes:0.0-askdata[1];
bidcount:count bidsizes;
askcount:count asksizes;

`orderbook insert(ex:bidcount#`kraken; sym:bidcount#`BTCUSD; price:bidprices;size:bidsizes);
`orderbook insert(ex:askcount#`kraken; sym:askcount#`BTCUSD; price:askprices;size:asksizes);
// Coinbase
OBInfo: 0N! .reqnew.g ":https://api.pro.coinbase.com/products/BTC-USD/book?level=3";
bidcount:count OBInfo`bids;
askcount:count OBInfo`asks;
biddata: flip OBInfo`bids;
askdata: flip OBInfo`asks;
bidprices:"F"$biddata[0];
bidsizes:"F"$biddata[1];
askprices:"F"$askdata[0];
asksizes:0.0-"F"$askdata[1];

`orderbook insert(ex:bidcount#`coinbasepro; sym:bidcount#`BTCUSD; price:bidprices;size:bidsizes);
`orderbook insert(ex:askcount#`coinbasepro; sym:askcount#`BTCUSD; price:askprices;size:asksizes);
// Bitstamp
OBInfo: 0N! .j.k .Q.hg ":https://www.bitstamp.net/api/order_book/?group=1";
bidcount:count OBInfo`bids;
askcount:count OBInfo`asks;
biddata: flip OBInfo`bids;
askdata: flip OBInfo`asks;
bidprices:"F"$biddata[0];
bidsizes:"F"$biddata[1];
askprices:"F"$askdata[0];
asksizes:0.0-"F"$askdata[1];

`orderbook insert(ex:bidcount#`bitstamp; sym:bidcount#`BTCUSD; price:bidprices;size:bidsizes);
`orderbook insert(ex:askcount#`bitstamp; sym:askcount#`BTCUSD; price:askprices;size:asksizes);
// Bitfinex
OBInfo: 0N! .j.k .Q.hg ":https://api-pub.bitfinex.com/v2/book/tBTCUSD/P3?len=100";
bookcount:count OBInfo;
bookdata: flip OBInfo;
bookprices:bookdata[0];
booksizes:bookdata[2];

`orderbook insert(ex:bookcount#`bitfinex; sym:bookcount#`BTCUSD; price:bookprices;size:booksizes);
// bitFlyer
OBInfo: 0N! .reqnew.g ":https://api.bitflyer.com/v1/getboard?product_code=BTC_USD";

biddata: OBInfo[`bids];
askdata: OBInfo[`asks];
bidprices:biddata[`price];
bidsizes:biddata[`size];
askprices:askdata[`price];
asksizes:0.0-askdata[`size];
bidcount:count bidsizes;
askcount:count asksizes;

`orderbook insert(ex:bidcount#`bitflyer; sym:bidcount#`BTCUSD; price:bidprices;size:bidsizes);
`orderbook insert(ex:askcount#`bitflyer; sym:askcount#`BTCUSD; price:askprices;size:asksizes);
// Poloniex
OBInfo: 0N! .reqnew.g ":https://poloniex.com/public?command=returnOrderBook&currencyPair=USDT_BTC&depth=100";

biddata: flip OBInfo[`bids];
askdata: flip OBInfo[`asks];
bidprices:"F"$biddata[0];
bidsizes:biddata[1];
askprices:"F"$askdata[0];
asksizes:0.0-askdata[1];
bidcount:count bidsizes;
askcount:count asksizes;

`orderbook insert(ex:bidcount#`poloniex; sym:bidcount#`BTCUSD; price:bidprices;size:bidsizes);
`orderbook insert(ex:askcount#`poloniex; sym:askcount#`BTCUSD; price:askprices;size:asksizes);
// Gemini
OBInfo: 0N! .reqnew.g ":https://api.gemini.com/v1/book/btcusd?limit_bids=0&limit_asks=0";

biddata:  OBInfo[`bids];
askdata:  OBInfo[`asks];
bidprices:"F"$biddata[`price];
bidsizes:"F"$biddata[`amount];
askprices:"F"$askdata[`price];
asksizes:0.0-"F"$askdata[`amount];
bidcount:count bidsizes;
askcount:count asksizes;

`orderbook insert(ex:bidcount#`gemini; sym:bidcount#`BTCUSD; price:bidprices;size:bidsizes);
`orderbook insert(ex:askcount#`gemini; sym:askcount#`BTCUSD; price:askprices;size:asksizes);
// Bittrex
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

// ItBit
OBInfo: 0N! .reqnew.g ":https://api.itbit.com/v1/markets/XBTUSD/order_book";

biddata: flip OBInfo[`bids];
askdata: flip  OBInfo[`asks];
bidprices:"F"$biddata[0];
bidsizes:"F"$biddata[1];
askprices:"F"$askdata[0];
asksizes:0.0-"F"$askdata[1];
bidcount:count bidsizes;
askcount:count asksizes;

`orderbook insert(ex:bidcount#`itbit; sym:bidcount#`BTCUSD; price:bidprices;size:bidsizes);
`orderbook insert(ex:askcount#`itbit; sym:askcount#`BTCUSD; price:askprices;size:asksizes);

// analysis
anal: select price:string price,size:size from () xkey select sum size by 100.0 xbar price from orderbook where price within (4000;20000);