% function by Henry Cox (19/10/17) to fit a nth order polynomial and plot
% the result

function [fit,yfit] = polyfitplot(X,Y,n)

% do the actual fit
fit = polyfit(X,Y,n);

% set out the powers of the polynomial
powers = n:-1:0;

% evaluate the fitted data
yfit = sum(bsxfun(@times,bsxfun(@power,X,powers),fit),2);


% plot
figure; plot(X,Y,'.','MarkerSize',10)
hold on
plot(X,yfit)
end



