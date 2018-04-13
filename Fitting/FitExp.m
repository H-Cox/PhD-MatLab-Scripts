% function to fit a exponential to some data with errors, inputs are x and
% y or x, y and an initial guess vector, [a,b] where y = a*exp(bx);
% written by Henry Cox 27/10/17
function [fit] = FitExp(varargin)

% import x and y data to be fit
x = varargin{1};
y = varargin{2};

% define gaussian function
modelfun = @(b,x)(b(1).*exp(b(2).*x));

% if initial guess is input then use it
if length(varargin)==3
    guess = varargin{3};
else
    % estimate initial guess
    guess = [max(y),5];
end

% perform fitting
try
    [beta,R,J,CovB,MSE,ErrorModelInfo] = nlinfit(x,y,modelfun,guess);
catch
    
    go = 1;
    while go == 1
        
        if ~exist('f','var')
            f=2;
        else
            f = f+1;
        end
        
        if f ==100000
            break
        end
        
        try
            [beta,R,J,CovB,MSE,ErrorModelInfo] = ...
                nlinfit(x(1:round(length(x)/f)),y(1:round(length(x)/f)),modelfun,guess);
            go = 0;
        catch
            go = 1;
        end
        
    end
end
        
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