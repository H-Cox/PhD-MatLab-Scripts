clear a
if ~(exist('Frames','var') && exist('xdata','var'))
    JFilamentends
end


% m = number of points on fibril
% n = number of frames
[m,n] = size(xdata);

n = n-1;

% set number of modes for fourier analysis:
nmax = 25;

Lc = [];
e2e = [];


warning('off','all')
for i = 1:n
    
    x = Frames(i).xf(1:end);
    y = Frames(i).yf(1:end);
    
    dx = diff(x);
    dy = diff(y);
    
    dr = sqrt(dx.^2+dy.^2);
    
    Lc = [Lc; sum(dr)];
    e2e = [e2e; sqrt((x(1)-x(end)).^2+(y(1)-y(end)).^2)];
    
    [Frames(i).modefit] = NumericalFModes(x,y,nmax);
    
    % extract coefficients
    a(:,i) = Frames(i).modefit.an;
    
    Frames(i).fourier_angle = Frames(i).modefit.Theta;
    Frames(i).fourier_angle = Frames(i).fourier_angle -...
        mean(Frames(i).fourier_angle) + ang(i);
    [Frames(i).fourier_xy(:,1),Frames(i).fourier_xy(:,2)] =...
        angle_to_position(Frames(i).fourier_angle,Frames(i).Lc);
    [Frames(i).fourier_xy(:,1),Frames(i).fourier_xy(:,2)] =...
        move_to_com(Frames(i).fourier_xy(:,1),Frames(i).fourier_xy(:,2),...
        Frames(i).com);
    fxdata(1:length(Frames(i).fourier_xy(:,1)),i) = Frames(i).fourier_xy(:,1);
    fydata(1:length(Frames(i).fourier_xy(:,1)),i) = Frames(i).fourier_xy(:,2);
    
end

Lcfit = FitGaussianHistogram(Lc);
Lcval = Lcfit.ci(2,2);
if Lcval > max(Lc(:))
    Lcval = max(Lc(:));
end
amean = mean(a,2);

[relax_angle,relax_s] = modes_to_angle(amean,1000,Lcval);

mean_angle = mean(ang);
mean_com = mean(com);

relax_angle = relax_angle - mean(relax_angle) + mean_angle;
[relax_x,relax_y] = angle_to_position(relax_angle,Lcval);
[relax_x,relax_y] = move_to_com(relax_x,relax_y,mean_com);

warning('on','all')

pic = 2;