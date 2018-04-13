function MSD = msd_correlation(varargin)

a = varargin{1}';

if length(varargin) == 2
    b = varargin{2}';
else
    b = varargin{1}';
end

a = a-mean(a,2);
b = b-mean(b,2);

MSD = zeros(size(a));
for i = 0:size(a,1)-1
    
    % calculate the MSD for this lag time
    MSD(i+1,:) = nanmean((a(1+i:end,:)-b(1:end-i,:)).^2);
end
end