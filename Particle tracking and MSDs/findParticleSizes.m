function [sizes] = findParticleSizes(tr)

sizes = [];
for p = 1:length(tr)
    sizes = [sizes; tr{p}(:,[3,5,7])];
end
end