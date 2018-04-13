function [plateaus] = MSDPlateau(varargin)

MSD_data = varargin{1};

[timepoints, datasets] = size(MSD_data);

if length(varargin)==1
    tenpercent = ceil(0.1*timepoints);
    limits = [tenpercent,5*tenpercent];
else
    limits = varargin{2};
end

plateaus = zeros([datasets,1]);

if datasets < 10
    for k = 1:datasets
    
        fit = fitdist(MSD_data(limits(1):limits(2),k),'Normal');
        plateaus(k) = [fit.mu];
    end
else

    parfor k = 1:datasets
    
        fit = fitdist(MSD_data(limits(1):limits(2),k),'Normal');
        plateaus(k) = [fit.mu];
    end
end

end