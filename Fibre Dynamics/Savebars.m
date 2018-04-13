

for i = 1:length(framedata)
    
    framedata(i).varan = var(framedata(i).an);
    An(i,:) = framedata(i).an(:);
    
    %{    
    bar(n,abs(framedata(i).an)./sum(abs(framedata(i).an)))
    axis([-0.5,5.5,0,1])
    
    saveas(gcf,['C:\Users\mbcx9hc4\Documents\MATLAB\PhD\16-11\23 coef\bar' num2str(i) '.png'])
    %}
end
