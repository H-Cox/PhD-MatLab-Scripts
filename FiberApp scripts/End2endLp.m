% Script by Henry Cox, 01/2017

% Designed to take a series of contour lengths and end to end distances
% from an Images structure pulled from FiberApp a series of fibrils and 
% return the persistence length by non-linear fitting of the general 
% equation relating the two.
% see https://en.wikipedia.org/wiki/Worm-like_chain
function [Lp,Lpbasic] = End2endLp(Lcs,end2end)

enan = isnan(end2end);
lnan = isnan(Lcs);
nans = enan+lnan;

Lcs(nans>0) = [];
end2end(nans>0) = [];


% input model function in general 3D form
model = @(c,x)sqrt(2.*c.*x.*(1+(c./x).*(exp(-x./c)-1)));

% perform basic linear fitting, applicable in the Lc>>Lp regime
Lpfitting = polyfit(sqrt(Lcs),end2end,1);

% calculate the persistence length from this method
Lpbasic = (Lpfitting(1,1).^2)./2;


% use the basic persistence length as first guess for non-linear fitting
[Lp,R,J,CovB]=nlinfit(Lcs,end2end,model,Lpbasic(1));

% calculate error on persistence length
Lp(2) = sqrt(CovB);

% plot the results
%{
figure
plot(Lcs,Lpfitting(1,1).*sqrt(Lcs)+Lpfitting(1,2))
hold on
plot(Lcs,end2end,'o')
hold on
plot(Lcs,model(Lp(1),Lcs))
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
%}

end