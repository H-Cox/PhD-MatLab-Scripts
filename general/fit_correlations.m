function [fits,lifetimes] = fit_correlations(cc)

[an,bn] = size(cc);

number_to_do = min([an,bn]);

frames = length(cc{1,1});

lags = 1:(frames-1)/2;

lags = [fliplr(-lags), 0 , lags];

for n = 1:number_to_do
    
    y = cc{n,n};
    
    y(lags<0)=[];
    x = lags(lags>=0).*0.01;
    if y(1) < 0
        y = -y;
    end
    fits(n) = FitExp(x,y,[max(y),-1]);
    
    lifetimes(n,1:2) = [-1/fits(n).xo(2,1), ...
                        fits(n).xo(2,2)/(fits(n).xo(2,1)^2)];
end

end