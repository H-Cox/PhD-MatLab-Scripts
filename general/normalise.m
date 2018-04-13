function [output] = normalise(input)

output = (input-nanmean(input,1))./(range(input)');

end