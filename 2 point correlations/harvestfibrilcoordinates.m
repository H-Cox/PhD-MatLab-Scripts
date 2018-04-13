%goodid = [1,2,3,4,5];%[77,84,56,10,5];
clearvars -except goodid

parfor z = 1:length(ids)
id = ids(z);
[x{z},y{z},com{z},mean_angle(z),Lc{z},Lcval(z),Frames{z},ang{z}] = import(id);
end

function [x,y,com,mean_angle,Lc,Lcval,Frames,ang] = import(id)
disp(id)
close all
path = 'C:\Users\mbcx9hc4\Dropbox (The University of Manchester)\paper 2\Fibrils\17-10-02 2-1\s 2-1-';
path2 = 'C:\Users\mbcx9hc4\Dropbox (The University of Manchester)\paper 2\Fibrils\';
filename = [path2 num2str(id) '.mat'];
%JFilImport;
%JFilamentends
load(filename);
x = xdata;
y = ydata;
mean_angle = nanmean(tang(:));
%save([path num2str(id) '.mat']);
end
