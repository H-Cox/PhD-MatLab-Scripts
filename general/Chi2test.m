function [ reducedchi2 ] = Chi2test( data,fit )
%Chi2test Calculates reduced chi2 for a model fit of a data set with errors
%   Input data = [yvalue, error], fit = [fit];


n=length(data(:,1));

diff=data(:,1)-fit;

chi2=sum((diff./data(:,2)).^2);

reducedchi2=chi2/n;


end

