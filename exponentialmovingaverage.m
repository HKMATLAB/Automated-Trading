%%
%Loading data to evaluate 
importfile('BTC-USD.csv');
%%
%Using exponential moving average to predict to buy in or sell out
[lead,lag] = movavg(Close,5,20,'e');
s =zeros(size(Close));
s(lead<=lag) = -1;             %Sell               
s(lead>lag) =1;                %Buy
r = [0; s(1:end-1).*diff(Close)];      %Return
w = cumsum(r);
sh = sqrt(250)*sharpe(r,0);        %Annual Sharp Ratio 
                                   %250trading day per year
%%
%Plotting figure for the closing price
createfigure([Close, lead, lag], [s, w]);
%%
%Best Parameter for lead and lag value
annualScaling = sqrt(250);
sh = nan(100, 100);
tic
for n = 1:100
    for m = n:100
        [~,~,sh(n,m)] = leadlag(Close,n,m,annualScaling,0);
    end
end
toc

%%
%Plot results for best parameter
figure
surfc(sh), shading interp, lighting phong
view([80 35]), light('pos',[0.5, -0.9, 0.05])
colorbar