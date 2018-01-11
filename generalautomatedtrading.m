%%Step 1, load data for analysis
importfile('filename.xls');
%manually open the variable you want to plot on the data, i.e 'Close'
%%Step 2, generate a simple lead/lag indicator
[lead,lag]=movavg(P,N,M,'e');
%%Step 3, generate a signal for trade
s=zeros(size(P));
s(lead>lag) = 1;                    %buy
s(lead<=lag) = -1;                  %sell
r = [0; s(1:end-1).*diff(P)];       %return
cumsumr = cumsum(r);
sh = sqrt(250)*sharpe(r,0);
%%Step 4, plotting a graph
createfigure([P, lead, lag], [s, cumsumr]);
