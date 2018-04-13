function [fit] = fitFreeEnd(s,w)

model1 = @(b,x)(x.^3./b(1)+b(2)^2);
model2 = @(b,x)(sqrt(x.^3./b(1))+b(2));

w2 = w.^2;

%fit.w2 = nlinfit2(s,w2,model1);
fit.w = nlinfit2(s,w,model2);

%figure;
plot(s,w,'.')
hold on; plot(fit.w.x,fit.w.yfit);%,fit.w2.x,sqrt(fit.w2.yfit))

fit.Lp(1) = fit.w.xo(1,1)/3;
%fit.Lp(2) = fit.w2.xo(1,1)/3;

end
