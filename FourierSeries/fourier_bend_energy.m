function [bend_energy] = fourier_bend_energy(modes,Lc)

mean_modes = nanmean(modes,2);
n = (1:size(mean_modes,1))';
bend_energy = sum((n.*pi().*mean_modes./Lc).^2);