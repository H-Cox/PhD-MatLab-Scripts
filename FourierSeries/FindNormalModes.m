function [normal_modes] = FindNormalModes(varargin)

l = 1:5;
alpha = (l+0.5).*pi();

% gn function, b(1) = L, b(2) = n
gn = @(x,b)(sqrt(2./b(1)).*cos((pi().*b(2)./b(1)).*(x+b(1)./2)));

% d/ds Eta for l odd and l even. b(1) = alpha*sqrt(L), b(2) = alpha/L
dEta_odd = @(x,b)(b(1).*(tan(b(2).*x)+tanh(b(2).*x)));
dEta_even = @(x,b)(b(1).*(1./tan(b(2).*x)+1./tanh(b(2).*x)));




