\p 5010
\l tools.q
\l reQ/req.q

//orderbook:([]ex:`$(); sym:`$(); price:`float$();size:`float$());

//OBInfo: 0N! .reqnew.g ":https://api.kraken.com/0/public/Depth?pair=XBTUSD";

//biddata: flip OBInfo[`result][`XXBTZUSD][`bids];
//askdata: flip OBInfo[`result][`XXBTZUSD][`asks];
//bidprices:"F"$biddata[0];
//bidsizes:"F"$biddata[1];
//askprices:"F"$askdata[0];
//asksizes:0.0-"F"$askdata[1];
//bidcount:count bidsizes;
//askcount:count asksizes;

// using crypto watch api for kraken to get a more full orderbook
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

anal: select price:string price,size:size from () xkey select sum size by 100.0 xbar price from orderbook where price within (4000;20000);