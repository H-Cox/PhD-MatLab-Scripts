ce = xsmsd;
ct = [];

for d = 1:length(ce)
    
    ct(1:length(ce{d}),d) = ce{d};
    
end

c = nanmean(ct,2);
e = nanstd(ct');
