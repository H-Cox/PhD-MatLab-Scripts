function [fit] = linearfitplot(X,Y)

fit = linearfit(X,Y);
yfit = fit(1,1).*X+fit(1,2);
figure; plot(X,Y,'.','MarkerSize',20)
hold on
plot(X,yfit)



