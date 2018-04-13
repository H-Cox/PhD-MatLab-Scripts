% Function to find the msd of the transverse magnitudes along a fibril, and
% find the plateau of the msd. 
clear c m fit plat p f i
% check existence of necessary variables
if ~exist('PP','var')
    if ~exist('xyf','var')
        JFilamentends
    end
    [PP,image] = FindPP(xyf);
end

if ~exist('Frames','var')
    JFilamentends
end

% check PP units are in microns
if sqrt((PP(end,3)-PP(1,3)).^2+(PP(end,4)-PP(1,4)).^2) > 1E3
    PP(:,3:4) = PP(:,3:4).*0.001;
end

% find the transverse magnitudes
[c] = JFilamentperpm2(Frames,PP);

% find number of points, p, and number of frames, f
[p,f] = size(c);
p = p-3;
% calculate the MSD for each point on the fibril and the plateau
for i = 1:p
    m(i,:) = simpleMSD(c(i,:)');
    
    %fit = fitdist(m(i,10:min([1000, length(m(i,:))]))','Normal');
    plat(i) = nanmean(m(i,100:1000));%[fit.mu];
end

lplat = log(plat);
lplat = lplat-min(lplat);
lplat(lplat == min(lplat)) =+ 0.001;
lplat = lplat./max(lplat);

rplat = ceil(lplat.*100);

map = jet(100);

figure2 = figure;
imshow(image);
hold on
for i = 1:p
    plot(PP(i,1)-50,PP(i,2)-50,'o',...
        'MarkerFaceColor',map(rplat(i),:),'Color',map(rplat(i),:))
    hold on
end
hold off

% plot it
x = linspace(0,mean(Lc),length(plat));
figure1 = figure;
axes1 = axes('Parent',figure1);

plot(x,plat,'LineWidth',3)
% Create xlabel
xlabel('Distance along fibril (um)');
% Create ylabel
ylabel('MSD Plateau (um^2)');
set(axes1,'FontSize',20)
box off
