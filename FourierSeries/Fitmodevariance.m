function [params,varfit] = Fitmodevariance(Lc,n,var,N)

% import inputs to function
x = Lc;
x = [x;N];
x = [x;n];

% define function to be fit, eqn 17 from doi:10.1083/jcb.120.4.923
modelfun = @(b,x)((2.*x(1)./(sqrt(b(1)).*x(3:end).*pi())).^2+...
    4.*b(2).*(1+(x(2)-1).*sin(x(3:end).*pi()./(2.*x(2))).^2)./x(1));

% set initial guess
guess = [Lc,0.01];

% do the fitting
[beta,R,J,CovB,MSE,ErrorModelInfo] = nlinfit(x,var,modelfun,guess);

% find errors on fitting parameters
errors = sqrt(diag(CovB));

% format for output
params = [beta',errors];

varfit = modelfun(beta,x);
end