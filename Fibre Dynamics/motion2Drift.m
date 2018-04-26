function [drift] = motion2Drift(path,fibril_ids)


% find the movement of the centre of mass of each fibril in each frame and
% then average it all.

for fib = 1:length(fibril_ids)
    
    load([path num2str(fibril_ids(fib)) '.mat'],'com')
    
    mx = com(:,1)-mean(com(:,1));
    my = com(:,2)-mean(com(:,2));
    
    movement_x(1:length(mx),fib) = mx;
    movement_y(1:length(my),fib) = my;
    
end

drift = [nanmean(movement_x,2), nanmean(movement_y,2)];


end