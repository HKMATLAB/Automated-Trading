%%Loading data to evaluate 
importfile('BTC-USD.csv');

%%Using exponential moving average to predict to buy in or sell out
[lead,lag] = movavg(Close,5,20,'e');
s =zeros(size(Close));
s(lead<=lag) = -1;             %Sell               
s(lead>lag) =1;                %Buy
r = [0; s(1:end-1).*diff(Close)];
w = cumsum(r);