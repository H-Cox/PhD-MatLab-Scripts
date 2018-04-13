% function to fit a gaussian to some data with errors
% written by Henry Cox 27/10/17
function [fit] = FitGaussian(x,y)

% define gaussian function
modelfun = @(b,x)(b(1).*exp(-(x-b(2)).^2./(2.*b(3).^2)));

% estimate initial guess
max_x = x(y==max(y));
guess = [max(y),mean(max_x),std(x)];

% perform fitting
[beta,R,J,CovB,MSE,ErrorModelInfo] = nlinfit(x,y,modelfun,guess);

% find the 95% confidence intervals
ci = nlparci(beta,R,'jacobian',J);

% find errors
errors = sqrt(diag(CovB));

% format for output
xo = [beta',errors];

xt = linspace(min(x),max(x),1000);
yt = modelfun(beta,xt);

% calculate resulting yfit
yfit = modelfun(beta,x);

% format the output
fit.yfit = yfit;
fit.xo = xo;
fit.R = R;
fit.MSE = MSE;
fit.ci = ci;
fit.x = xt;
fit.y = yt;
end