
n = length(tr);

for i = 1:n
      
    avgpos(i,:) = mean(tr{i}(:,1:2),1);
       
end

clear i n
