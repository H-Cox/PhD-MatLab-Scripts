function [widths] = extractFibreWidths(Images)

widths = [];

for j = 1:length(Images)

    for i = 1:length(Images(j).xy)

        tempwidth = Images(j).width{i};
        hadW = Images(j).hadWarning{i};
        
        widths = [widths; tempwidth(hadW==0,:)];
        
    end
end
widths(widths(:,1)<0,:)=[];
end