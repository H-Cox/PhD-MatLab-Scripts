function [x,y] = move_to_com(x,y,com)

xmean = mean(x);
ymean = mean(y);

x = x + com(1) - xmean;
y = y + com(2) - ymean;

end

