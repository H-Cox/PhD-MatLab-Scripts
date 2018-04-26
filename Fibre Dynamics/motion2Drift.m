function [drift] = motion2Drift(path,fibril_ids)


% find the movement of the centre of mass of each fibril in each frame and
% then average it all.

for fib = 1:length(fibril_ids)
    
    load([path num2str(fibril_ids(fib)) '.mat'],'com')
    
    movement_x(:,fib) = diff(com(:,1));
    movement_y(:,fib) = diff(com(:,2));
    
end

drift = [nansum(movement_x,2), nansum(movement_y,2)];
end