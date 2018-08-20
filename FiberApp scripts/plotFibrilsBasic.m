function plotFibrilsBasic(image,fibrilData)



figure;

imshow(image);


for f = 1:length(fibrilData.xy)
    
    hold on
    plot(fibrilData.xy{f}(1,:),fibrilData.xy{f}(2,:),'LineWidth',2)   
    
    
end
end
