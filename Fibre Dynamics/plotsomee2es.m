n = floor(size(epts,1)./8);

for i = 1:8;
    
    hold on
    plot(epts((i-1)*n+1,[1 3]),epts((i-1)*n+1,[2 4]));
end
hold on
plot(epts(end,[1 3]),epts(end,[2 4]));