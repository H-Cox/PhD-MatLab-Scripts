function [flop_modes] = floppy_modes(varargin)

a = varargin{1};
b = varargin{2};

if length(varargin) >= 3
    smooth = varargin{3};
else
    smooth = 1;
end

[an,num_frames] = size(a);
[bn,~] = size(b);

flop_modes = cell(an,bn,smooth);

% loop through each a mode
for k = 1:an
    
    % loop through each b mode
    for l = 1:bn
        m1 = a(k,:)-mean(a(k,:));
        m2 = b(l,:)-mean(b(l,:));
        
        m1 = m1./(max(m1)-min(m1));
        m2 = m2./(max(m2)-min(m2));
        [r,lags] = xcorr(m1,m2);
        
        %r = r(lags>=0);
        
        flop_modes{k,l,1} = r;
        
        if smooth == 2
            flop_modes{k,l,2} = smoothn(r,10000);
        end
            
    end
end
end
    