
% script to pull data points off a matlab figure (needs to be open)


h = gcf; %current figure handle

axesObjs = get(h, 'Children');  %axes handles

dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes

objTypes = get(dataObjs, 'Type');  %type of low-level graphics object

xdata = get(dataObjs, 'XData');  %data from low-level grahics objects
ydata = get(dataObjs, 'YData');

clear h axesObjs dataObjs objTypes