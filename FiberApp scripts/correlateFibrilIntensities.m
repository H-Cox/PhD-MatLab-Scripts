function [G] = correlateFibrilIntensities(Images)

G = [];
for im = 1:6
    for f = 1:length(Images(im).fint)
        
        f1 = normalise(Images(im).fint{f}{1}');
        f2 = normalise(Images(im).fint{f}{2}');
        
        G = [G; corrh(f1,f2)];
    end
end
end
 