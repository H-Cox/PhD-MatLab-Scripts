function G = corrh(x,y)



Exy = nanmean(x.*y,2);

covxy = Exy-nanmean(x,2).*nanmean(y,2);

G = covxy./(nanstd(x,0,2).*nanstd(y,0,2));
end