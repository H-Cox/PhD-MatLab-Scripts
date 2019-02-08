function [fxdata,fydata] = correctFxFy(fxdata,fydata)

mx = nanmean(fxdata);
my = nanmean(fydata);

polfit = @(b,x)(b(1)+b(2).*x+b(3).*x.^3);

t = linspace(0,length(mx)/100,length(mx));

fitx = nlinfit2(t,mx-mean(mx),polfit);
fity = nlinfit2(t,my-mean(my),polfit);

fxdata = fxdata-fitx.yfit;
fydata = fydata-fity.yfit;

end