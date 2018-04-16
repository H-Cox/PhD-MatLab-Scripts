function [fit, image1, image2] = alignImages(image1,image2)

image1 = double(image1./max(image1(:)));
image2 = double(image2./max(image2(:)));
disp('Performing initial alignment...')
fit = fitAlignment(image1,image2);

displayShift(fit.xyshift)

disp('Refining alignment...')
image3 = imtranslate(image2,fit.xyshift);
fit.check = fitAlignment(image1,image3);
fit.xyshift = fit.xyshift+fit.check.xyshift;
count = 0;

while sum(fit.check.xyshift)~=0
    displayShift(fit.xyshift)
    count = count + 1;
    disp('Refining alignment...')
    image3 = imtranslate(image2,fit.xyshift);
    fit.check = fitAlignment(image1,image3);
    fit.xyshift = fit.xyshift+fit.check.xyshift;
    if count > 4
        break;
    end
end

disp('Alignment ok.')
end

function fit = fitAlignment(image1,image2)

[r,c] = size(image1);

if max([r,c]) > 1000
    shrinkFactor = round(max([r,c])/1000);
end

sF = shrinkFactor;

% remove some pixels otherwise correlation takes ages
imgCorrelation = xcorr2(image1(1:sF:end,1:sF:end),image2(1:sF:end,1:sF:end));
imgCorrelation = imgCorrelation./max(imgCorrelation(:));

[ysize,xsize] = size(imgCorrelation);

x = (-(xsize-1)/2:(xsize-1)/2);
y = (-(ysize-1)/2:(ysize-1)/2);

imgx = repmat(x,[ysize,1]);
imgy = repmat(y',[1,xsize]);

gauss2D = @(b,x)(b(1).*exp(-(x(:,1)-b(5)).^2./b(3))+b(2).*exp(-(x(:,2)-b(6)).^2./b(4)));

xFit = [imgx(:),imgy(:)];
yFit = imgCorrelation(:);

xfitMax = xFit(yFit==1,:);

initialGuess = [0.5,0.5,1,1,xfitMax];

% limit the fit size to improve accuracy
yFit(abs(xFit(:,1))>5)=[];
xFit(abs(xFit(:,1))>5,:)=[];
yFit(abs(xFit(:,2))>5)=[];
xFit(abs(xFit(:,2))>5,:)=[];

fit = nlinfit2(xFit,yFit,gauss2D,initialGuess);

fit.xyshift = round(fit.xo(5:6,1).*sF);

end

function displayShift(shift)

xshift = shift(1);
yshift = shift(2);

disp(['Current (x,y) shift in pixels is (' num2str(xshift) ',' num2str(yshift) ').']);

end
