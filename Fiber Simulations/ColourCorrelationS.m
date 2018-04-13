% Script to calculate the correlation of points along a fibre.
%function [mcorrelation] = ColourCorrelationS(blocks,efac,ifac,sfac)
% Tidy up
clear correlationAF correlationCY correlation correlationX mcorrelation test
bl = 1;

blocks = 100;
efac = 1;
ifac = 8;
sfac = 0;
wfac = 0.3;

wc = 0.5.*smoothn(abs(interpo(expand(randn(50,1),50),3)),500);

constantw = 1;

% max length scale
%R = 100;
%figure
% loop through each fibre
for i = 1:100
    xe = round(abs(randn(1)),1)+bl;
        %x = [expand([0.5;0.5],10); interpo([0.5;1],5) ;expand([1;1],10*xe);...
           %interpo([1;0.5],5);expand([0.5;0.5],10)]; 
        %x = [interpo(expand(randi(2,abs(blocks)+1,1),efac+1),ifac) ;expand([1;1],10*xe);...
           %interpo(expand(randi(2,abs(blocks)+1,1),efac+1),ifac)];
        x = smoothn(interpo(expand(randi(2,abs(blocks)+1,1),efac),ifac),sfac,'robust');
        y = smoothn(interpo(expand(randi(2,abs(blocks)+1,1),efac),ifac+1),sfac,'robust');%(((x-1)*-1));%smoothn(interpo(expand(randi(2,abs(blocks)+1,1),efac+1),ifac),sfac,'robust')-1;%
               
        if constantw == 0
            maxl = min([length(x),length(y),length(wc)]);
            x = x(1:maxl).*wc(1:maxl);
            y = y(1:maxl).*wc(1:maxl);
        else
            wa = 1 + abs(wfac.*(interpo(expand(randn(500,1),1),2)));
            wb = 1 + abs(wfac.*(interpo(expand(randn(500,1),1),2)));
            w2 = 1 + abs(wfac.*smoothn((interpo(expand(randn(500,1),3),10)).*0,1000));
            maxl = min([length(x),length(wa),length(w2)]);
            x = x(1:maxl).*wa(1:maxl).*w2(1:maxl);
            y = y(1:maxl).*wb(1:maxl).*w2(1:maxl);
        end
        
        % import fibril data
        ptdata = [x, y];
        if i == 0
            figure
            hold on
            if constantw == 0;
                plot(wc(1:maxl),'-')
            end
            plot(w2(1:maxl))
            %plot(wa(1:maxl))
            plot(x(1:maxl),'.-')
            plot(y(1:maxl),'.-')
            
        end
        %{
        % test criteria if correlating blocks
        lim = 0.1;
       
        xdata(ptdata(:,1)./ptdata(:,3)>lim,1) = 1;
        xdata(ptdata(:,2)./ptdata(:,3)>lim,2) = 1;
        xdata(ptdata(:,1)./ptdata(:,3)<=lim,1) = 0;
        xdata(ptdata(:,2)./ptdata(:,3)<=lim,2) = 0;
        xdata(ptdata(:,3)==0,:) = 0;
        %}
        correlation{i} = [];
        norm = 'coeff';
        % main three if statements to calculate each correlation
        %if AFcounts/totalcounts > check;
            clear G
            [R1,L1] = xcov(ptdata(:,1),norm);
            R1 = R1(L1>=0);
            %[G,r] = get_autocorr1D(ptdata(:,1) , ones(size(ptdata(:,1))), size(ptdata(:,1),1)-1, 0);
            correlation{i}(1:length(R1),1) = R1; 
           
        %else
            %correlation{i}(1:3000,1) = NaN;
        %end
        
        %if CYcounts/totalcounts > check;
            clear G
            [R2,L2] = xcov(ptdata(:,2),norm);
            R2 = R2(L2>=0);
            %[G,r] = get_autocorr1D(ptdata(:,2) , ones(size(ptdata(:,2))), size(ptdata(:,1),1)-1, 0);
            correlation{i}(1:length(R2),2) = R2;
            
            
        %else
            %correlation{j}(1:3000,2) = NaN;
        %end
        
        %if AFcounts/totalcounts > check && CYcounts/totalcounts > check;
        clear G
            [R3,L3] = xcov(ptdata(:,1),ptdata(:,2),norm);
            R3 = R3(L3>=0);
            %[G,r] = get_crosscorr1D(ptdata(:,1),ptdata(:,2),ones(size(ptdata(:,1))), size(ptdata(:,1),1)-1, 0);
            correlation{i}(1:length(R3),3) = R3;
            
        %else
            %correlation{j}(1:3000,3) = NaN;
        %end
        
        % prepare data to be exported
        exportAF = correlation{i}(:,1);
        exportCY = correlation{i}(:,2);
        exportX = correlation{i}(:,3);
        
        % normalise if necessary
        % exportAF = exportAF./max(exportAF);
        % exportCY = exportCY./max(exportCY);
        
        
        % set any zeros to -9999999 so they can be found later
        exportAF(exportAF == 0) = -9999999;
        exportCY(exportCY == 0) = -9999999;
        exportX(exportX == 0) = -9999999;
        
        % export data
        correlationAF(1:length(exportAF),i) = exportAF;
        correlationCY(1:length(exportCY),i) = exportCY;
        correlationX(1:length(exportX),i) = exportX;
        
        clear exportAF exportCY exportX R1 R2 R3 L1 L2 L3
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
mcorrelation(:,1) = nanmean(correlationAF,2);
mcorrelation(:,2) = nanmean(correlationCY,2);
mcorrelation(:,3) = nanmean(correlationX,2);

for k = 1:size(correlationAF,1);
    mcorrelation(k,4) = nanstd(correlationAF(k,:));
    mcorrelation(k,5) = nanstd(correlationCY(k,:));
    mcorrelation(k,6) = nanstd(correlationX(k,:));
end

clear z
%correlation = correlation(1:300,:);
R = min([50,length(mcorrelation(:,1))]);
%{
% plot without errorbars
hold on
plot(1:R,mcorrelation(:,1),'+-')
plot(1:R,mcorrelation(:,2),'.-')
plot(1:R,mcorrelation(:,3),'*-')
%}

% plot with errorbars
%figure
hold on
errorbar(0.02.*(1:R-1),mcorrelation(2:R,1)+1,mcorrelation(2:R,4),'x-')
errorbar(0.02.*(1:R-1),mcorrelation(2:R,2)+0.5,mcorrelation(2:R,5),'o-')
errorbar(0.02.*(1:R-1),mcorrelation(2:R,3),mcorrelation(2:R,6),'*-')
%}
xlabel('Distance')
ylabel('Autocorrelation')

%set(gca,'ygrid','on')