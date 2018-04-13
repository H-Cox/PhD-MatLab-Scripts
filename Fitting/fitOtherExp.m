function [lf,fit] = fitOtherExp(x,y)
warning('off')
double = @(b,x)(b(1).*exp(-x./b(2).^2));%-b(3).*exp(-x./b(4).^2));
figure
for p = 1:2%size(x,1)
    fit(p) = nlinfit2(x(p,:),y(p,:),double,[1,0.1]);
    
    lf = sqrt(abs(fit(p).xo(2,1)));
    %l2 = sqrt(abs(fit(p).xo(4,1)));
    %ratio = max([l1,l2])./min([l1,l2]);
    
    %lf(p,1:3) = [sort([l1,l2]),ratio];
    hold on
    plot(x(p,:),y(p,:),fit(p).x,fit(p).yfit);
end
warning('on')
end