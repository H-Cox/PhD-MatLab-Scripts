function ans=linearfit(x,y)
    % Linear least-squares fit and error
    [p,s]=polyfit(x,y,1);
    
    deltaf=s.normr/sqrt(s.df);
    
    % Estimate covariance matrix of p using inverse of R
    C=deltaf^2*inv(s.R)*inv(s.R)';
    
    % Extract elements on diagonal
    deltap=sqrt(diag(C));
    
    ans = [p ; deltap'];
end

