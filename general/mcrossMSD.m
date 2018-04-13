function [output] = mcrossMSD(data1,data2)

[data1size] = min(size(data1));
[data2size] = min(size(data2));

m = cell(data1size,data2size);

parfor k = 1:data1size
    for l = 1:data2size
        m{k,l} = crossMSD(data1(k,:),data2(l,:));
    end
    
end

output = m;


end