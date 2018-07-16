function [SSS] = findSSS2(Data)

uData = Data(:,1);
lData = Data(:,2);

t = logspace(log10(2),log10(60),10);

uData(lData<t(1)) = [];
lData(lData<t(1)) = [];
uData(lData>t(end)) = [];
lData(lData>t(end)) = [];

means = [1.004871685731409,1.047684440059817,1.723391818951046,...
    2.363621830702823,3.665077189714777,5.860073764953016,...
    8.038081734384015,12.638447499281213,19.305755060914016];

stds = [1.468688927651043,1.626084461140570,2.042818280334899,...
    2.344908950758513,2.914392991018827,3.742633579625446,...
    3.911244025048376,4.764121800930343,6.844457600869426];

limitRange = -10:1:100;
SSS = zeros([length(limitRange),2]);

for l = 1:length(limitRange)
    
    y3 = means+limitRange(l).*stds;
    
    for s = 1:length(y3)
    
    uT = HenryMethod(uData(lData>t(s)));
    lT = lData(lData>t(s));
    uT = uT(lT<t(s+1));
    
    func = @(x)(length(x(x>y3(s))));
    
    if length(uT) > 1
        temp = bootstrp(1000,func,uT);
    
        SSS(l,1) = SSS(l,1) + mean(temp);
        SSS(l,2) = sqrt(SSS(l,2).^2 + std(temp).^2);
    else
        SSS(l,1) = SSS(l,1) + func(uT);
    end
            
    end
end

SSS = SSS./length(uData);

end