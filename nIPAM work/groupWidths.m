function [new_widths] = groupWidths(current_s,current_widths)
% this only selects widths which are separated by 100nm, whereas normally
% the separation would depend on the length of the fibril, so small fibrils
% contribute more to the data.

fibrils = length(current_s);

new_widths = [];

for f = 1:fibrils
    
    new_s = 0:0.1:round(max(current_s{f}),1);
    
    new_w = convertToNewX(current_s{f},current_widths{f},new_s);
    
    new_widths = [new_widths, new_w];
    
end

end

