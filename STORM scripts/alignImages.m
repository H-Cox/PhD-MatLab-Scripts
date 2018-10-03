function [fit, image1, image2] = alignImages(image1,image2)

image1 = double(image1./max(image1(:)));
image2 = double(image2./max(image2(:)));
disp('Performing initial alignment...')
fit = fitAlignment(image1,image2);

[value,fit.xyshift] = checkShift(fit.xyshift);
displayShift(fit.xyshift)

disp('Refining alignment...')
image3 = imtranslate(image2,fit.xyshift);
fit.check = fitAlignment(image1,image3);
fit.xyshift = fit.xyshift+fit.check.xyshift;
count = 0;
    
[value,fit.xyshift] = checkShift(fit.xyshift);
    
if value == 0        
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
        [value,fit.xyshift] = checkShift(fit.xyshift);
        if value == 1
            break;
        end
    end
    disp('Alignment ok.')
end
end


function fit = fitAlignment(image1,image2)

[r,c] = size(image1);

shrinkFactor = 1;

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

gauss2D = @(b,x)(b(1).*exp(-((x(:,1)-b(2)).^2./b(4)+(x(:,2)-b(3)).^2./b(5))));

xFit = [imgx(:),imgy(:)];
yFit = imgCorrelation(:);

xfitMax = xFit(yFit==1,:);
xfitMaxM = mean(xfitMax,1);
initialGuess = [1,0,0,1,1];

% limit the fit size to improve accuracy
yFit(abs(xFit(:,1))>20)=[];
xFit(abs(xFit(:,1))>20,:)=[];
yFit(abs(xFit(:,2))>20)=[];
xFit(abs(xFit(:,2))>20,:)=[];

fit = nlinfit2(xFit,yFit,gauss2D,initialGuess);

fit.xyshift = round(fit.xo(2:3,1).*sF);

end

function displayShift(shift)

xshift = shift(1);
yshift = shift(2);

disp(['Current (x,y) shift in pixels is (' num2str(xshift) ',' num2str(yshift) ').']);

end

function [value,shift] = checkShift(shift)
value = 0;
if abs(shift(1)) > 100
    disp('Error on x fit');
    shift(1) = 0;
    value = 1;
end
if abs(shift(2)) > 100
    disp('Error on y fit');
    shift(2) = 0;
    value = 1;
end
end
