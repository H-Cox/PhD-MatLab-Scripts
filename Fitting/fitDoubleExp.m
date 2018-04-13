function [lf,fit] = fitDoubleExp(x,y)
warning('off')
double = @(b,x)(b(1).*exp(-x./b(2).^2)+b(3).*exp(-x./b(4).^2));
figure
for p = 1:size(x,1)
    fit(p) = nlinfit2(x(p,:),y(p,:),double,[1,0.1,1,1]);
    
    l = [sqrt(abs(fit(p).xo(2,1))),sqrt(abs(fit(p).xo(4,1)))];
    
    m = find(l==min(l));
    if m ==1
        n = 2;
    else
        n = 1;
    end
    
    l1 = l(m);
    l2 = l(n);
    
    ratio = l2./l1;
    
    el1 = fit(p).xo(2*m,2)./(2.*l1);
    el2 = fit(p).xo(2*n,2)./(2.*l2);
    a1 = fit(p).xo((m-1)*2+1,1);
    a2  = fit(p).xo((n-1)*2+1,1);
    a1e = fit(p).xo((m-1)*2+1,2);
    a2e  = fit(p).xo((n-1)*2+1,2);
    lf(p,1:9) = [l1,el1,l2,el2,ratio,a1,a1e,a2,a2e];
    hold on
    plot(x(p,:),y(p,:),fit(p).x,fit(p).yfit);
end
warning('on')
end
