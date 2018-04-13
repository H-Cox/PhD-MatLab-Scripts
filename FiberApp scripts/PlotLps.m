% Script to summarise all persistence lengths
% Henry Cox 19/12/2016

AllLps = 0;
Lps = 0;
for i = 1:length(Images)
    
    for j = 1:length(Images(i).xy)
        
        for k = 1:floor(Images(i).length_nm(j)./1000)
            
            AllLps = [AllLps; Images(i).Lp(j)];
        end
        
        Lps = [Lps; Images(i).Lp(j)];
    end
end

AllLps = AllLps(2:end);
Lps = Lps(2:end);
figure
hold on
histogram(AllLps,100,'Normalization','probability');
histogram(Lps,100,'Normalization','probability');

clear i j k