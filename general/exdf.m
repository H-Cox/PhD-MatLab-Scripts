function [cdf,xpts] = exdf(data)


cdf = linspace(1/length(data),1,length(data));

xpts = sort(data);

end