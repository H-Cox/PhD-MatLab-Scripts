function [Lp] = msdplat2lp(msdplat,Lc,n)

Lp = 4/(n^2*pi()^2*msdplat/(Lc));