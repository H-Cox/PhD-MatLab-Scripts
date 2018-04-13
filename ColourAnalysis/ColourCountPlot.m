pos = [680 558 560 420];
z = 1;

% fibrenumber
for j = 1;

xpts = Images(z).xy_nm{j}(1,:);
ypts = Images(z).xy_nm{j}(2,:);
    
maxx = max(xpts) + 700;
minx = min(xpts) - 700;
maxy = max(ypts) + 700;
miny = min(ypts) - 700;

%AF = XYSnip(Images(z).dataAF,maxy,maxx,miny,minx);
CY = XYSnip(Images(z).dataCY,maxy,maxx,miny,minx);
x = 10:10:10*length(Images(z).counts{j});


figh = figure(j);
set(figh,'position',[pos(1) pos(2)/4 pos(3:4)*2])
subplot(2,1,1)
hold on% add first plot in 2 x 1 grid
plot(CY(:,1)./1000,(CY(:,2)-40)./1000,'g.','MarkerSize',1)
%plot(AF(:,1),AF(:,2),'r.','MarkerSize',1)
hold on
plot(Images(z).xy_nm{j}(1,:)./1000,Images(z).xy_nm{j}(2,:)./1000,'k','LineWidth',1)
%plot(Images(z).sxy{j}(1,:),Images(z).sxy{j}(2,:),'k','LineWidth',1)

xlabel('x co-ordinate (nm)')
ylabel('y co-ordinate (nm)')
axis equal tight


subplot(2,1,2)       % add second plot in 2 x 1 grid
hold on
%plot(x,Images(z).counts{j}(:,1),'r')
plot(x,Images(z).counts{j}(:,2),'g')    
xlabel('Distance along fibre (nm)')
ylabel('Localisation counts')
%}
clear xpts ypts maxx minx maxy miny AF CY x
end