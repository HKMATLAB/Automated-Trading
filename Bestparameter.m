%% Best parameter for lead and lag
%
annualScaling= sqrt(250);      %250 being the annual number of trade day
leadlag(P,1,20,annualScaling);

sh= nan(100,100);
tic
for n = 1:100
    for m = n:100
        [~,~,sh(n,m)] = leadlag(P,n,m,annualScaling);
    end
end
toc

%% Plotting a graph to estimate the best parameter
figure
surfc(sh), shading interp, lighting phong
view([80 35]), light('pos', [0.5, -0.9, 0.05])
colorbar

%%  Plotting for the best sharpe ratio
[maxSH, row] = max (sh);
[maxSH, col] = max(maxSH);
leadlag(P, row(col), col, annualScaling);