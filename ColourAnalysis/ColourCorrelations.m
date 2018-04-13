% Script to calculate the correlation of points along a fibre.

% Tidy up
clear correlationAF correlationCY correlation correlationX test
 
% Variable to allow combination of multiple images
bonus = 0;
lim = 0.1;
test = 0.3;
% loop through each image
for z = 1:2
    % loop through each fibre
    for j = 1:length(Images(z).blockpts)
        Images(z).correlation{j} =[];
        % import data and add criteria to slice data if needed
        cdata = Images(z).counts{j};
        ptdata = cdata;
        
        %ptdata(:,1) = Images(z).blockpts{j}(:,1);
        %ptdata(:,2) = Images(z).blockpts{j}(:,2);
        
        %{
        ptdata(cdata(:,1)./cdata(:,3)>lim,1) = 1;
        ptdata(cdata(:,2)./cdata(:,3)>lim,2) = 1;
        ptdata(cdata(:,1)./cdata(:,3)<=lim,1) = 0;
        ptdata(cdata(:,2)./cdata(:,3)<=lim,2) = 0;
        ptdata(cdata(:,3)==0,:) = 0;
        %}
        
        % matlab method to calculate correlation
        [R1,L1] = xcov(ptdata(:,1));
        Images(z).correlation{j}(:,1) = R1(L1>=0);
        [R2,L2] = xcov(ptdata(:,2));
        Images(z).correlation{j}(:,2) = R2(L2>=0);
        [R3,L3] = xcov(ptdata(:,1),ptdata(:,2));
        Images(z).correlation{j}(:,3) = R3(L3>=0);
        %}
        
        
        %{
        % home made method to calculate correlation
        % loop through the different length scales of the fibre
        for i = 0:length(ptdata(:,1))-1 %Images(z).blockpts{j})-1
            %{
            % method using means
            x1 = ptdata(1+i:end,1);
            y1 = ptdata(1:end-i,1);
            x2 = ptdata(1+i:end,2);
            y2 = ptdata(1:end-i,2);
            
            test(i+1,1) = sum((x1-mean(x1)).*(y1-mean(y1)))./...
                sqrt(sum((x1-mean(x1)).^2.*(y1-mean(y1)).^2));
            test(i+1,2) = sum((x2-mean(x2)).*(y2-mean(y2)))./...
                sqrt(sum((x2-mean(x2)).^2.*(y2-mean(y2)).^2));
            test(i+1,3) = sum((x1-mean(x1)).*(y2-mean(y2)))./...
                sqrt(sum((x1-mean(x1)).^2.*(y2-mean(y2)).^2));    
            %}
            %{
            Images(z).correlation{j}(i+1,1) = sum((x1-mean(x1)).*(y1-mean(y1)))./...
                sqrt(sum((x1-mean(x1)).^2.*(y1-mean(y1)).^2));
            Images(z).correlation{j}(i+1,2) = sum((x2-mean(x2)).*(y2-mean(y2)))./...
                sqrt(sum((x2-mean(x2)).^2.*(y2-mean(y2)).^2));
            Images(z).correlation{j}(i+1,3) = sum((x1-mean(x1)).*(y2-mean(y2)))./...
                sqrt(sum((x1-mean(x1)).^2.*(y2-mean(y2)).^2));
            %}
            %{
            test(i+1,1) = mean(ptdata(1+i:end,1).*ptdata(1:end-i,1));
            test(i+1,2) = mean(ptdata(1+i:end,2).*ptdata(1:end-i,2));
            test(i+1,3) = mean(ptdata(1+i:end,1).*ptdata(1:end-i,2));
            %}
            
            % calculate mutual correlations of 647 and 568 channels
            Images(z).correlation{j}(i+1,1) = mean(ptdata(1+i:end,1).*ptdata(1:end-i,1));
            Images(z).correlation{j}(i+1,2) = mean(ptdata(1+i:end,2).*ptdata(1:end-i,2));
            
            % calculate cross correlation
            Images(z).correlation{j}(i+1,3) = mean(ptdata(1+i:end,1).*ptdata(1:end-i,2));
            
        end
        %}
        % prepare data to be exported
        exportAF = Images(z).correlation{j}(:,1);
        exportCY = Images(z).correlation{j}(:,2);
        exportX = Images(z).correlation{j}(:,3);
        
        % set any zeros to -9999999 so they can be found later
        exportAF(exportAF == 0) = -9999999;
        exportCY(exportCY == 0) = -9999999;
        exportX(exportX == 0) = -9999999;
        %{
        % normalisation
        exportAF = exportAF./(sum(Images(z).counts{j}(:,1))./Images(z).length_nm(j));
        exportCY = exportCY./(sum(Images(z).counts{j}(:,2))./Images(z).length_nm(j));
        exportX = exportX./(sum(Images(z).counts{j}(:,3))./Images(z).length_nm(j));
        %}
        % export data
        correlationAF(1:length(Images(z).blockpts{j}),j+bonus) = exportAF./max(exportAF);
        correlationCY(1:length(Images(z).blockpts{j}),j+bonus) = exportCY./max(exportCY);
        correlationX(1:length(Images(z).blockpts{j}),j+bonus) = exportX;
        
        
        % tidy up
        clear exportAF exportCY exportX i j ptdata cdata R1 R2 R3 L1 L2 L3
    end
    
    % revise bonus variable for next image
    bonus = bonus + length(Images(z).xy_nm);
end

% Create NaNs where zeros are introduced at the end of fibrils shorter than
% longest fibril
correlationAF(correlationAF == 0) = NaN;
correlationCY(correlationCY == 0) = NaN;
correlationX(correlationX == 0) = NaN;

% Replace the true zeros with zero
correlationAF(correlationAF == -9999999) = 0;
correlationCY(correlationCY == -9999999) = 0;
correlationX(correlationX == -9999999) = 0;

% Average over all fibrils
correlation(:,1) = nanmean(correlationAF,2);
correlation(:,2) = nanmean(correlationCY,2);
correlation(:,3) = nanmean(correlationX,2);

for k = 1:size(correlationAF,1);
    correlation(k,4) = nanstd(correlationAF(k,:));
    correlation(k,5) = nanstd(correlationCY(k,:));
    correlation(k,6) = nanstd(correlationX(k,:));
end

clear z
correlation = correlation(1:300,:);
%{
% plot without errorbars
hold on
plot(10:10:10*length(correlation(:,1)),correlation(:,1),'+-')
plot(10:10:10*length(correlation(:,1)),correlation(:,2),'.-')
plot(10:10:10*length(correlation(:,1)),correlation(:,3),'*-')
%}


% plot with errorbars
hold on
errorbar(10:10:10*length(correlation(:,1)),correlation(:,1),correlation(:,4),'+-')
errorbar(10:10:10*length(correlation(:,1)),correlation(:,2),correlation(:,5),'.-')
errorbar(10:10:10*length(correlation(:,1)),correlation(:,3),correlation(:,6),'*-')
%}
xlabel('distance (nm)')
ylabel('correlation (arb.)')
%axis([0,2000,-inf,inf])