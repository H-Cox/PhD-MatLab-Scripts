
xpp = objects(1).para;
ypp = objects(1).perp;

for i = 2:length(objects)
    
    xpp = [xpp; objects(i).para];
    ypp = [ypp; objects(i).perp];
    
end
