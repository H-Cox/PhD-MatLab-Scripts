% Written by Henry Cox (05/10/17) to fit a 2D gaussian function to two
% dimensional data. Inputs are the data to be fit and optionally a first
% guess at the fit. (e.g. [fit,xy] = FitGaussian2D(data,guess);)

function [fit,xy] = FitGaussian2D(varargin)
    
    % import data
    data = varargin{1};
    
    % determine size of data and set up the xy grid to evaluate the
    % gaussian
    x = 1:size(data,2);
    y = 1:size(data,1);
    y = y';
    
    x = repmat(x,[size(data,1),1]);
    y = repmat(y,[1,size(data,2)]);
    
    xy(:,:,1) = x;
    xy(:,:,2) = y;
    
    % copy the user supplied initial guess or determine one if not supplied
    if length(varargin) == 2
        guess = varargin{2};
    else
        guess = [1,0,1,0,1];
    
        maxi = find(data==max(data(:)));
        if length(maxi) > 1
            pick = round(length(maxi)/2);
            guess(2) = 1+floor(maxi(pick)/size(data,1));
            guess(4) = rem(maxi(pick),size(data,1));
        else
            guess(2) = 1+floor(maxi/size(data,1));
        	guess(4) = rem(maxi,size(data,1));
        end
    end
    
    % set up options for the fitting
    options = optimoptions('lsqcurvefit','Display','off');
    
    % run the fit
    fit = lsqcurvefit(@Gaussian2D,guess,xy,data,[-Inf,-Inf,-Inf,-Inf,-Inf]...
        ,[Inf,Inf,Inf,Inf,Inf],options);