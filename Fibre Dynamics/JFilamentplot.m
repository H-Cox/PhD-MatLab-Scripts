
n = max(Frame);

c = linspace(0,1,n);
figure
for i = 1:5:max(Frame);
    
    xf = X(Frame==i).*65;
    yf = Y(Frame==i).*65;
    hold on
 
    if i < n/2
        plot(xf,yf,'Color',[1-2*c(i),2*c(i),0])
    else
        plot(xf,yf,'Color',[0,2-2*c(i),2*c(i)-1])
    end
end

plot(PP(:,3),PP(:,4))