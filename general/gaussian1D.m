function [y]=gaussian1D(x,mean,sigma,constant)


if ~exist('constant','var')
    y = 1 / sqrt((2*pi) * sigma) .* exp(-1/2 .* (x-mean).^2./sigma);
else
    y = constant .* exp(-1/2 .* (x-mean).^2./sigma);
end

end