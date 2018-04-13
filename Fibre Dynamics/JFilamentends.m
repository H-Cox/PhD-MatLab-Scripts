epts = [];
e2e = [];
ang = [];
com = [];
skip = [];
xyf = [];
Lc = [];
tang = [];

% in microns
framesize = 0.13;

if ~exist('Frame','var')

    Frame = stretch;
    X = VarName3;
    Y = VarName4;

    clear stretch VarName1 VarName2 VarName3 VarName4
end

for i = 1:max(Frame)-min(Frame)
    fnum = min(Frame) + i - 1;
    Frames(i).Frame = fnum;
    
    xf = X(Frame==fnum).*framesize;
    yf = Y(Frame==fnum).*framesize;
    xdata(1:length(xf),i) = xf;
    ydata(1:length(xf),i) = yf;
    Frames(i).xf = xf;
    Frames(i).yf = yf;
    dx = diff(xf);
    dy = diff(yf);    
    tang(1:length(dx),i) = atan(dy./dx);
    ff = linspace(fnum,fnum,length(yf))';
    
    xyf = [xyf; xf, yf, ff];
        
    if length(xf) < 1
        skip = [skip, Frame];
    else

        dr = sqrt(dx.^2+dy.^2);
        Lc = [Lc; sum(dr)];
        epts = [epts; xf(1),yf(1),xf(end),yf(end)];
        e2e = [e2e; sqrt((xf(1)-xf(end)).^2+(yf(1)-yf(end)).^2)];
        ang = [ang; atan((yf(1)-yf(end))./(xf(1)-xf(end)))];
        com = [com ; mean(xf) , mean(yf)];

                
        Frames(i).dx = dx;
        Frames(i).dy = dy;
        Frames(i).dr = dr;
        Frames(i).Lc = sum(dr);
        Frames(i).epts = [xf(1),xf(end);yf(1),yf(end)];
        Frames(i).e2e = sqrt((xf(1)-xf(end)).^2+(yf(1)-yf(end)).^2);
        Frames(i).tang = atan(dy./dx);
        Frames(i).ang = [atan((yf(1)-yf(end))./(xf(1)-xf(end)))];
        Frames(i).com = [mean(xf),mean(yf)];
        
        
    end
end

Lcfit = FitGaussianHistogram(Lc);
Lcval = Lcfit.ci(2,2);
[Lpval,~] = End2endLp(Lc,e2e);

    