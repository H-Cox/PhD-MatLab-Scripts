clearvars -except ID

e2evals = zeros(length(ID),1);
Lcvals = zeros(length(ID),1);
Lpcurv = zeros(length(ID),1);
Lpvals = zeros(length(ID),2);
mean_modes = zeros(25,length(ID));

parfor z = 1:length(ID)
id = ID(z);
[e2evals(z), Lcvals(z), Lpvals(z,:),mean_modes(:,z),x{z},y{z}] = process(id);
end

function [end2end, Lcval, Lpval,mean_modes,x,y] = process(id)
load(['fibdata ' num2str(id) '.mat']);
JFil2end2end
close all
end