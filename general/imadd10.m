function [image] = imadd10(im,increase)

holdColour = 0;

if holdColour ~= 0

a = repmat(im(:,1),[1,increase]);
b = repmat(im(:,end),[1,increase]);

im = [a,im,b];
c = repmat(im(1,:),[increase,1]);
d = repmat(im(end,:),[increase,1]);

image = [c;im;d];

else
a = zeros(size(im,1),increase);

im = [a,im,a];

b = zeros(increase,size(im,2));

image = [b;im;b];
end

