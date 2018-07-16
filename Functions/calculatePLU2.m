
function [Z] = calculatePLU2(U,L,beta,lambda,sigma)
% funciton to calculate the probability of a fibril having a certain length
% and bending energy given the parameters beta, lambda and gamma


if ~exist('beta','var')
    beta = 1.66;
end
if ~exist('lambda','var')
    lambda = 0.2394;
end
if ~exist('sigma','var')
    sigma = 1;
end

[ur,uc] = size(U);
[lr,lc] = size(L);

U = repmat(U',[1,lc]);
L = repmat(L,[uc,1]);

PL = lambda.*exp(-lambda.*L);

expo = exp(-(0.0260.*L.^beta-U).^2./(2.*sigma.^2));

coeff = 1/(sqrt(2.*pi().*sigma.^2));

Z = expo.*coeff.*PL;

end