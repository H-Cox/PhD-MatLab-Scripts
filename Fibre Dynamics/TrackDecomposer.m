

for i = 1:length(objects)
    
    [perp{i}, para{i}] = DecomposeMotion(objects(i).track(:,1:2),atan(m));
    
    objects(i).perp = perp{i}(:,:);
    objects(i).para = para{i}(:,:);
    
    
    objects(i).ellips(1) = max(objects(i).perp)-min(objects(i).perp);
    objects(i).ellips(2) = max(objects(i).para)-min(objects(i).para);
    
    objects(i).ratio = objects(i).ellips(1)./objects(i).ellips(2);
    ratios(i) = objects(i).ratio;    
end