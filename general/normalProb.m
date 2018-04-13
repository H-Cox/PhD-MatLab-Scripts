function [probability] = normalProb(x,beta)

normalFunction = @(b,x)(exp(-(x-b(1)).^2./(2.*b(2).^2))./sqrt(2.*pi().*b(2).^2));

probability = normalFunction(beta,x);

end