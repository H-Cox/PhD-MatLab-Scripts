function [mean_MSD,l] = meanMSD(MSD)

[frames,~] = size(MSD);

l = unique(round(logspace(0,log10(frames),200)));

mean_MSD = zeros(length(l),1);
mean_error = zeros(length(l),1);

for f = 1:length(l)
    warning('off')
    try
        [data] = loghist(MSD(l(f),:),10);
        fit(f) = FitGaussian(log10(data(:,1)),data(:,2));
        mean_MSD(f) = 10^(fit(f).xo(2,1));
        mean_error(f) = mean_MSD(f)*log(10)*fit(f).xo(2,2);
    catch
        mean_MSD(f) = NaN;
        mean_error(f) = NaN;
    end
end

mean_MSD(:,2) = mean_error;
warning('on')
end