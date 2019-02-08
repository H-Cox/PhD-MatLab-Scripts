function [values] = tDist(x,mean,sigma,scale)

distribution = makedist('tLocationScale','mu',mean,'sigma',sigma,'nu',scale);

values = pdf(distribution,x);

end