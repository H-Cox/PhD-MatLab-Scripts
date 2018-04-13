% script to plot tracks
clear paramag perpmag
i = 1;
j = length(objects2);
figure
hold on

paramag = zeros(j,1);
perpmaf = zeros(j,1);
% loop which cycles through tracks
while i <= j;
   plot(objects2(i).para(:,1),objects2(i).perp(:,1));
   
   
   paramag(i) = abs(max(objects2(i).para(:,1))-min(objects2(i).para(:,1)));
   perpmag(i) = abs(max(objects2(i).perp(:,1))-min(objects2(i).perp(:,1)));
   i = i + 1;
end