function [SSS] = findSSS(uData,lData,limits)


t = logspace(log10(2),log10(60),10);

for s = 1:length(limits)
    
    uT = HenryMethod(uData(lData>t(s)));
    lT = lData(lData>t(s));
    uT = uT(lT<t(s+1));
    
    y3 = limits(s);
    
    func = @(x)(length(x(x>y3))/length(x));
    try
        bt = bootstrp(10000,func,uT);
    
        SSS(s,1:2) = [mean(bt),std(bt)];
    catch
        SSS(s,1:2) = [NaN, NaN];
    end
            
    
end
end
