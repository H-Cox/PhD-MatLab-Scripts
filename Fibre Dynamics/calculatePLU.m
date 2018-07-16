function [Z] = calculatePLU(U,L,beta,lambda,gamma)
% funciton to calculate the probability of a fibril having a certain length
% and bending energy given the parameters beta, lambda and gamma


if ~exist('beta','var')
    beta = 1.66;
end

if ~exist('lambda','var')
    lambda = 0.2394;
end

if ~exist('gamma','var')
    gamma = 0.3382;
end

[ur,uc] = size(U);
[lr,lc] = size(L);

U = repmat(U',[1,lc]);
L = repmat(L,[uc,1]);

PL = lambda.*exp(-lambda.*L);

LGB = lambda./(gamma.*beta);

LG = lambda./gamma;

PU = LGB.*exp(-LG.*U.^(1/beta)).*U.^((beta-1)./beta);

PLU = PL.*PU;

Z = PLU;

end
