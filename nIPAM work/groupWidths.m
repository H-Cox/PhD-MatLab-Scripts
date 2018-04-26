function [new_widths] = groupWidths(current_s,current_widths)
% this only selects widths which are separated by 100nm, whereas normally
% the separation would depend on the length of the fibril, so small fibrils
% contribute more to the data.

fibrils = length(current_s);

new_widths = [];

for f = 1:fibrils
    
    s = current_s{f};
    w = current_widths{f};
    
    new_s = 0:0.1:round(max(s),1);
    
    new_w = convertToNewX(s,w,new_s);
    
    new_widths = [new_widths, new_w];
    
end

end

