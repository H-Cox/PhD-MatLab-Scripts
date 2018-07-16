function [y]=gaussian1D(x,mean,sigma,constant)

n = size(x, 2);
xmu = bsxfun(@minus,x,mean);


if ~exist('constant','var')
    y = 1 / sqrt((2*pi)^n * det(sigma)) .* exp(-1/2 * sum(xmu/sigma .* xmu, 2));
else
    y = constant .* exp(-1/2 * sum(xmu/sigma .* xmu, 2));
end

end