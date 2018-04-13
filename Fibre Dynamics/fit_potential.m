function [data] = fit_potential(potential_data)

[pts,~] = size(potential_data);
warning('off')
for p = 1:pts
    
    fit = FitGaussianHistogram(potential_data(p,:),30);
    data.fit{p} = fit;
    data.width(p) = fit.xo(3,1);
    
end

end