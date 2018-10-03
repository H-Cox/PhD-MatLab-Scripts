function G = corrh(x,y,dim)

if ~exist('dim','var')
    dim = 1;
end

Exy = nanmean(x.*y,1);

covxy = Exy-nanmean(x,1).*nanmean(y,1);

G = covxy./(nanstd(x,0,1).*nanstd(y,0,1));

end