

% function takes in a index for a white object on a black background and
% returns an image with the white object just surrounded by 5 black
% pixels, and the position of the top left corner in the original image

function [isolatedObject, position] = BWIsolate(BWObject, originalImageSize)

% show the orignal image
originalImage=zeros(originalImageSize);
originalImage(BWObject)=1;       
%figure, imshow(originalImage)

imageHeight = originalImageSize(1);

% find the limits of the image
minimum_x = ceil(min(BWObject)/imageHeight);
maximum_x = ceil(max(BWObject)/imageHeight);
minimum_y = min(rem(BWObject,imageHeight));
maximum_y = max(rem(BWObject,imageHeight));

% find the position of the final isolatedObject in the original image
position = [minimum_y - 5, minimum_x - 5];

% method using image %

% export the object from its limits
objectImage = originalImage(minimum_y:maximum_y, minimum_x:maximum_x);

%figure, imshow(objectImage)

% add 5 pixels black space around it
isolatedObject = zeros([size(objectImage,1)+10,size(objectImage,2)+10]);
isolatedObject(6:end-5,6:end-5)=objectImage;

%figure, imshow(isolatedObject)

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