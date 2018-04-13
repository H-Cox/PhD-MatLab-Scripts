function [SSS] = findSSS2(Data)
SSS = 0;
uData = Data(:,1);
lData = Data(:,2);

t = logspace(log10(2),log10(60),10);
y3 = [5.410938468684538,5.925937823481529,7.851846659955744,9.398348682978362,12.408256162771258,17.087974503829350,19.771813809529142,26.930812902072240,39.839127863522290];

for s = 1:length(y3)
    
    uT = HenryMethod(uData(lData>t(s)));
    lT = lData(lData>t(s));
    uT = uT(lT<t(s+1));
    
    func = @(x)(length(x(x>y3(s))));
    
    SSS = SSS + func(uT);
    
            
    
end

SSS = SSS./length(uData);

end