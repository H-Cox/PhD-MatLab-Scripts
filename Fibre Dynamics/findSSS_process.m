clear
number = [0,1,8,64];

SSS = [];

for i = 1:4
    
    SSS = [SSS; processSSS(number(i))];
    
end


function [SSS] = processSSS(number)

load(['FiberApp H ' num2str(number) '.mat']);
AlltheLps
data = [Us', Lcs'];

SSS = findSSS(data);

clearvars -except SSS number

load(['FiberApp L ' num2str(number) '.mat']);
AlltheLps
data = [Us', Lcs'];

SSS = [SSS; findSSS(data)];

end

function SSS = findSSS(data)

nfunc = @(x)(findSSS2(x));
nSSS = bootstrp(1000,nfunc,data);
SSS(1,1:3) = [mean(nSSS),std(nSSS),size(data,1)];

mfunc = @(x)(findSSS3(x));
mSSS = bootstrp(1000,mfunc,data);
SSS(2,1:3) = [mean(mSSS),std(mSSS),sum(data(:,2))];

end



