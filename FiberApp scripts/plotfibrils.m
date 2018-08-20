function plotfibrils(image,fibrilData,fibrilcolour)

limit = log10(7.7);

figure

imshow(image(20:end-80,20:end-80));

map1 = spring(1000);
map2 = winter(1000);
jetmap = jet(1000);
sKey = zeros(length(fibrilData.xy),1);
map = zeros(length(sKey),3);

sKey(fibrilcolour>limit)=1;

uS = fibrilcolour(fibrilcolour<=limit);
pS = fibrilcolour(fibrilcolour>limit);

uSk = ceil(setRange(uS))+1;
pSk = ceil(setRange(-pS))+1;
redmap = redCMap(500);
sCount = 1;
pCount = 1;

for f = 1:length(fibrilData.xy)
    
    if sKey(f) == 1
        map = redmap(pSk(pCount),:);
        pCount = pCount + 1;
        hold on
        plot(fibrilData.xy{f}(1,:)-20,fibrilData.xy{f}(2,:)-20,'LineWidth',2,'Color',map)
    else
        
        %map = jetmap(500-uSk(sCount),:);
        %sCount = sCount + 1;
    end
    
    
    
end
end


function [out] = setRange(data)

minD = min(data);

out = data-minD(1);

maxO = max(out);

out = round(out.*480./maxO(1));

end