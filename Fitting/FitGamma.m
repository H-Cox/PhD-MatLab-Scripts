function [fit] = FitGamma(x,y)

% define gamma distribution
modelfun = @(b,x)(x.^(b(1)-1).*exp(-x.*b(2)).*b(3));

% perform fitting
[fit] = nlinfit2(x,y,modelfun);

fit.alpha = fit.xo(1,:);
fit.beta = fit.xo(2,:);
fit.check = abs(fit.xo(3,1)-fit.beta(1)^fit.alpha(1)/gamma(fit.alpha(1)));
end 