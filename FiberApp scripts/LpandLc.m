Lps = [];
sLps = [];
Lcs = [];
for z = 1: length(Images);
    
    Lps = [Lps, Images(z).Lp];
    Lcs = [Lcs, Images(z).length_nm];
end

for z = 1:length(Images)
    
    k = 1;

    for i = 1:length(Images(z).length_nm)
    
        
        for j = 0:ceil(Images(z).length_nm(i)./1000)-1;
        
            Images(z).sLp(k) = Images(z).Lp(i);
            k = k+1;
            
        end
        
        
    end
    
    sLps = [sLps, Images(z).sLp];
    
end

clear i j k z
figure
subplot(2,1,1)
hold on% add first plot in 2 x 1 grid
histogram(Lps,0:2500:45000,'Normalization','probability')
%histogram(ALps,0:2500:450000,'Normalization','probability')
plot([mean(Lps),mean(Lps)],[0,1])
%plot([mean(ALps),mean(ALps)],[0,1])
xlabel('Persistence length (nm)')
ylabel('Counts')

subplot(2,1,2)       % add second plot in 2 x 1 grid
hold on
histogram(Lcs,0:1000:30000,'Normalization','probability')
%histogram(ALcs,0:1000:30000,'Normalization','probability')
plot([mean(Lcs),mean(Lcs)],[0,1])
%plot([mean(ALcs),mean(ALcs)],[0,1])
xlabel('Contour length (nm)')
ylabel('Counts')
