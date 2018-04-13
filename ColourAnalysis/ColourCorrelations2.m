% Script to calculate the correlation of points along a fibre.

% Tidy up
clear correlationAF correlationCY correlation correlationX test
AF = 0;
CY = 0;
X = 0;
check = 0.2;
bonus = 0;
norm = 'coeff';

% loop through each image
for z = 1:2;%length(Images)
    % loop through each fibre
    for j = 1:length(Images(z).blockpts)
        
        % calculate counts of each type and total in fibril
        totalcounts = sum(Images(z).counts{j}(:,3));
        AFcounts = sum(Images(z).counts{j}(:,1));
        CYcounts = sum(Images(z).counts{j}(:,2));
        
        % import fibril data
        ptdata = Images(z).counts{j};%./totalcounts;
        
        % test criteria if correlating blocks
        lim = 0.1;
        cdata = Images(z).counts{j};
        xdata(ptdata(:,1)./ptdata(:,3)>lim,1) = 1;
        xdata(ptdata(:,2)./ptdata(:,3)>lim,2) = 1;
        xdata(ptdata(:,1)./ptdata(:,3)<=lim,1) = 0;
        xdata(ptdata(:,2)./ptdata(:,3)<=lim,2) = 0;
        xdata(ptdata(:,3)==0,:) = 0;
        %}
        Images(z).correlation{j} = [];
        % main three if statements to calculate each correlation
        if AFcounts/totalcounts > check;
            [R1,L1] = xcov(ptdata(:,1),norm);
            R1 = R1(L1>=0);
            %[G,r] = get_autocorr1D(ptdata(:,1) , ones(size(ptdata(:,1))), 100, 0);
            Images(z).correlation{j}(1:length(R1),1) = R1; 
            AF = AF + 1;
        else
            Images(z).correlation{j}(1:3000,1) = NaN;
        end
        
        if CYcounts/totalcounts > check;
            [R2,L2] = xcov(ptdata(:,2),norm);
            R2 = R2(L2>=0);
            %[G,r] = get_autocorr1D(ptdata(:,2) , ones(size(ptdata(:,2))), 100, 0);
            Images(z).correlation{j}(1:length(R2),2) = R2;
            
            CY = CY + 1;
        else
            Images(z).correlation{j}(1:3000,2) = NaN;
        end
        
        if AFcounts/totalcounts > check && CYcounts/totalcounts > check;
            [R3,L3] = xcov(ptdata(:,1),ptdata(:,2),norm);
            R3 = R3(L3>=0);
            %[G,r] = get_crosscorr1D(ptdata(:,1),ptdata(:,2),ones(size(ptdata(:,1))), 100, 0);
            Images(z).correlation{j}(1:length(R3),3) = R3;
            X = X + 1;
        else
            Images(z).correlation{j}(1:3000,3) = NaN;
        end
        
        % prepare data to be exported
        exportAF = Images(z).correlation{j}(:,1);
        exportCY = Images(z).correlation{j}(:,2);
        exportX = Images(z).correlation{j}(:,3);
        
        % normalise if necessary
        % exportAF = exportAF./max(exportAF);
        % exportCY = exportCY./max(exportCY);
        hold on
        %plot(0.02:0.02:0.98,exportX(3:2:100))
        
        % set any zeros to -9999999 so they can be found later
        exportAF(exportAF == 0) = -9999999;
        exportCY(exportCY == 0) = -9999999;
        exportX(exportX == 0) = -9999999;
        
        % export data
        correlationAF(1:length(exportAF),j+bonus) = exportAF;
        correlationCY(1:length(exportCY),j+bonus) = exportCY;
        correlationX(1:length(exportX),j+bonus) = exportX;
        
        clear exportAF exportCY exportX R1 R2 R3 L1 L2 L3
        
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
%correlation = correlation(1:300,:);
%{
% plot without errorbars
hold on
plot(60:50:2960,correlation(5:5:296,1),'+-')
plot(60:50:2960,correlation(5:5:296,2),'.-')
plot(60:50:2960,correlation(5:5:296,3),'*-')
%}


% plot with errorbars
hold on
%errorbar(0.02:0.02:0.98,correlation(3:2:100,1)+1,correlation(3:2:100,4),'o')
%errorbar(0.02:0.02:0.98,correlation(3:2:100,2)+0.5,correlation(3:2:100,5),'o')
errorbar(0.02:0.02:0.98,correlation(3:2:100,3),correlation(3:2:100,6),'o')
%}
xlabel('Distance (nm)')
ylabel('Autocorrelation')
%axis([0,1,-0.2,1])
set(gca,'ygrid','on')