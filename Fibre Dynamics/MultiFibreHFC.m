

n = 0:5;
n=n';

for i = 1 : length(framedata)
    
    [framedata(i).an,framedata(i).s,framedata(i).L] = HowardFourierComponents(framedata(i).xy,n);
    
end

