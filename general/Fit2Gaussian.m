% function to fit a gaussian to some data with errors
% written by Henry Cox 27/10/17
function [fit] = Fit2Gaussian(x,y)

% define gaussian function
modelfun = @(b,x)(b(1).*exp(-(x-b(2)).^2./(2.*b(3).^2))+...
    b(4).*exp(-(x-b(5)).^2./(2.*b(6).^2)));

% estimate initial guess
[ys,I] = sort(y,'Descend');
guess = [max(y),x(I(1)),std(x)/4,max(y),x(I(2)),std(x)/4];

% perform fitting
[beta,R,J,CovB,MSE,ErrorModelInfo] = nlinfit(x,y,modelfun,guess);

% find the 95% confidence intervals
ci = nlparci(beta,R,'jacobian',J);

% find errors
errors = sqrt(diag(CovB));

% format for output
xo = [beta',errors];

% calculate resulting yfit
yfit = modelfun(beta,x);

% format the output
fit.yfit = yfit;
fit.xo = xo;
fit.R = R;
fit.MSE = MSE;
fit.ci = ci;
end