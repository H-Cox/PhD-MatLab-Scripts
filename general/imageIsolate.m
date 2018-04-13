

% function takes in a index for a white object on a black background and
% the original image it was in. Returns a cropped version of the original
% image just containing the the object

function [isolatedImage] = imageIsolate(BWObject, originalImage, maximum_border)

% enter the maximum border around the object you want
default_space=maximum_border;

% show the orignal image
originalBW=zeros(size(originalImage));
originalBW(BWObject)=1;       
figure, imshow(originalBW)

imageHeight = size(originalImage,1);

% find the limits of the image
minimum_x = ceil(min(BWObject)/imageHeight);
maximum_x = ceil(max(BWObject)/imageHeight);
minimum_y = min(rem(BWObject,imageHeight));
maximum_y = max(rem(BWObject,imageHeight));

if minimum_x < default_space
    x_space = minimum_x - 1;
else
    x_space = default_space;
end

if size(originalImage,2)-maximum_x < default_space
    x_space2 = size(originalImage,2)-maximum_x - 1;
else
    x_space2 = default_space;
end

if minimum_y < default_space
    y_space = minimum_y - 1;
else
    y_space = default_space;
end

if size(originalImage,2)-maximum_y < default_space
    y_space2 = size(originalImage,1)-maximum_y - 1;
else
    y_space2 = default_space;
end
% method using image %

% export the object from its limits


isolatedImage = originalImage(minimum_y-y_space:maximum_y+y_space2, minimum_x-x_space:maximum_x+x_space2);

figure, imshow(isolatedImage)

% method using indexs, not currently working
%{
objectWidth = maximum_x - minimum_x;
objectHeight = maximum_y - minimum_y;


objectxShifted = BWObject - ((minimum_x-1)*imageHeight);
objectxyShifted = objectxShifted - (minimum_y-1);


objectxyShiftedImage=zeros([objectHeight,objectWidth]);
objectxyShiftedImage(objectxyShifted)=1;
figure, imshow(objectxyShiftedImage)


isolatedObject = (objectxyShifted + 5 + 5 * (objectWidth + 10));


imageHeight = objectHeight + 10;
imageWidth = objectWidth + 10;
imageSize = [imageHeight,imageWidth];

isolatedImage = zeros(imageSize);
isolatedImage(isolatedObject) = 1;
figure, imshow(isolatedImage);
%}
end

%{
1   5   9
2   6   10
3   7   11
4   8   12
%}