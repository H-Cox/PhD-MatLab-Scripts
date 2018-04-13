
names = {'1','3','5','7','10','20','50','100'};

for n = 1:length(names)
    
    filename = ['26 - ' names{n} '000lp.mat'];
    
    load(filename)
    
    ImageDataToStruct
    
    AlltheLps
    
    close all
    
    Lpdata(n,1:length(Lps)) = Lps;
    cLp(n) = CurvLp(1);
    eLp(n) = E2ELp(1);
end

for n = 1:length(names)
    
    hold on
    histogram(Lpdata(n,:)./(str2num([names{n} '000'])./2),100);
end