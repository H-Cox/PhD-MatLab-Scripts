% Non-linear fitting with errors and no need for initial guess. Inputs are
% x, y and modelfun. Optional additional inputs are the guess vector.
% written by Henry Cox 27/10/17
function [fit] = nlinfit2(x,y,modelfun,guess,xlims,ylims,makeX)

original_X = x;
original_Y = y;

if exist('xlims','var') 
    [x,y] = stripX(x,y,xlims);
end

if exist('ylims','var') 
    [y,x] = stripX(y,x,ylims);
end

% make sure the size is the same (both should be 1D vectors)
if size(x) ~= size(y)
    y = y';
end

% if initial guess is not input then guess it
if ~exist('guess','var')
    % estimate initial guess
    guess = [1];
    
    % loop to determine the right number of inputs to be fit.
    while length(guess) > 0
        % try to evaluate the function with the current guess
        try
            % if it works then continue with rest of function
            test = modelfun(guess,x);
            break
        catch ME 
            % if it is due to a subscript error add one to guess and try
            % again
            if ME.identifier == 'MATLAB:badsubscript'
                guess = [guess, 1];
            % if not then throw the error properly
            else 
                rethrow(ME)
            end
        end
    end              
end

% perform fitting
[beta,R,J,CovB,MSE,ErrorModelInfo] = nlinfit(x,y,modelfun,guess);

% find the 95% confidence intervals
ci = nlparci(beta,R,'jacobian',J);

% find errors
errors = sqrt(diag(CovB));

% format for output
xo = [beta',errors];

if ~exist('makeX','var')
    fit.x = original_X;
else
    fit.x = linspace(min(original_X),max(original_X),max([1000,length(original_X)]));
end

% calculate resulting yfit
yfit = modelfun(beta,fit.x);

% format the output
fit.yfit = yfit;
fit.xo = xo;
fit.R = R;
fit.MSE = MSE;
fit.ci = ci;
end
