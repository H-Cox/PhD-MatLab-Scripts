function [output] = XYSnip(input, maxy,maxx,miny,minx)

% script to remove localisations based on certain criteria
input(input(:,2)>maxy,:) = [];
input(input(:,2)<miny,:) = [];

input(input(:,1)>maxx,:) = [];
input(input(:,1)<minx,:) = [];

output = input;
