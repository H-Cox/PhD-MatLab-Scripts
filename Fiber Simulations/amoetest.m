function [score] = amoetest(varargin)

global tcorr


mcorrelation = ColourCorrelationS(varargin{1},varargin{2},varargin{3},varargin{4});

maxl = min([length(mcorrelation(:,1)),40]);
hold on
%plot(0.02.*(1:maxl),mcorrelation(1:maxl,1))
hold on

score = sum(abs(mcorrelation(1:maxl,1)-tcorr(1:maxl,1)));