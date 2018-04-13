
r = Im1(:,1);
Corr = log(Im1(:,2));


currentstep = abs(r(2) - r(1));

factor = currentstep/0.1;

interpolatedr = interpo(r,round(factor));
interpolatedcorr = interpo(Corr,round(factor));

targetr = 30:10:4000;
finalCorr = zeros(length(targetr),1);

for i = 1:length(targetr);
    
    finderseries = abs(interpolatedr - targetr(i));
    target = min(abs(interpolatedr - targetr(i)));
    finalCorr(i) = interpolatedcorr(finderseries == target);
    
end
