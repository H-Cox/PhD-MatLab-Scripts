function [beta,prob] = fitmanyGaussians(uFit,lFit,uData,lData)

t = logspace(log10(2),log10(60),10);

for s = 1:length(t)-1
    
    uTest = HenryMethod(uFit(lFit>t(s)));
    lTest = lFit(lFit>t(s));
    
    uTest = uTest(lTest<t(s+1));
    % change between lognormal or normal here
    fit = fitdist(log(uTest)','normal');
    fit2 = FitGaussianHistogram(log(uTest),50);
    beta(s,:) =[fit.mu,fit.sigma,fit2.xo(2,1),fit2.xo(3,1)];
    
    uT = HenryMethod(uData(lData>t(s)));
    lT = lData(lData>t(s));
    uT = uT(lT<t(s+1));
    
    y3 = exp(beta(s,3)+3.*beta(s,4));
    
    prob(s,:) = [length(uT(uT>y3)),length(uT(uT<=y3)),length(uT)];
    
end





end
    