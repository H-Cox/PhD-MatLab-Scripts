%This script allows to define two points on an image and the algorithm will
%output the intensity profile along the straight line that connects the two
%points and calculate the MSD of the extracted "peak".

%Count the number of .tif images in the working folder
no_images = length(dir('*.tif'));
profile = [];

fname = '1-5';
%Use the first frame of the video to select two xy points. These will be
%used to calculate the intensity profile along the straight line that
%connects the two.
V = VideoReader([fname '.avi']);
V.currentTime = 0;

I = readFrame(V);
imshow(I); imcontrast;
[xline,yline] = getpts;
close all; clear I;

%Fit a first order polynomial to the two points defining the straigh
%line used.
p = polyfit([xline(1,1) xline(2,1)],...
    [yline(1,1) yline(2,1)],1);

%Initialise the vectors for the gaussian function fits to be saved in.
Fit = []; track = zeros(no_images,2);

%Choose the first and last frame of the sequence to be fitted.
frame_lim(1,1) = input('Please enter the 1st frame to be fitted: ');
frame_lim(1,2) = input('Please enter the last frame to be fitted: ');
V.currentTime = (frame_lim(1,1)-1)/V.FrameRate;
%Loop through the chosen frames and fit a gaussian function along the
%specified line intensity profile.
for i = frame_lim(1,1):frame_lim(1,2)
    
    frame = readFrame(V);
    %[cx,cy,c] = improfile(I,xi,yi,n) additionally returns the spatial
    %coordinates of the pixels, cx and cy, of length n.
    [profile{i,1}(:,1), profile{i}(:,2), profile{i}(:,3)] =...
        improfile(frame,xline,yline,'bicubic');
    
    %Use the Ezyfit toolbox to perform a Gaussian fit on the intensity line
    %profile acquired above. The gauss functions is defined as
    %y = a*exp(-(x-x0)^2/(2*s^2)).
    %The output of the function is: gaussFit.m(1,1) = a,
    %gaussFit(1,2)=sigma and gaussFit(1,3)=x_0;
    Fit = ezfit(profile{i,1}(:,1),profile{i,1}(:,3),'gauss');
    
    %Use the fitted first order polynomial to evaluate y based on the above
    %value extracted from the gaussian fit.
    track(i,1) = Fit.m(1,3);
    track(i,2) = p(1,1)*Fit.m(1,3)+p(1,2);
    
    %Copy the sigma,mu and a parameters into a structure Fit   <-FOR NO
    %REASON
    %{
    Fit.sigma(i,1) = Fit.m(1,2);
    Fit.mu(i,1) = Fit.m(1,3);
    Fit.alpha(i,1) = Fit.m(1,1);
    %}
    clear frame Fit
    
end

clear i iter no_images

%Filter out localisations very far from the centre of the track to
%avoid MSD overestimations. This will replace outliers with the mean of
%the data.
[track_temp(:,1),track_temp(:,2)] = ...
    Filter_outliers(track(:,1),track(:,2));


%Plot the unfiltered and filtered track for visual verification.
subplot(1,2,1)
scatter(track(:,1),track(:,2),'r');
subplot(1,2,2);
scatter(track_temp(:,1),track_temp(:,2));

clear track;
track = track_temp;
clear track_temp;

%Save the data extracted to a pooled data structure, but check if it's
%good first.
choice = input('Enter 0 to delete the track or 1 to save the track: ');
if choice == 1
    if exist('MSD_pool','var')==0
        %Compute the MSD based on the above fit
        [t,MSD] = MSD_single(track,9,0.077);
        t = transpose(t);
        %Initialise the matrices which will hold the MSD, the frames which
        %were processed, the Line Limits used for the line intensity
        %profile and the track of the ER.
        MSD_pool = zeros(length(MSD),1);
        frameLimPool = zeros(1,2);
        LineLimits = zeros(1,4);
        Tracks = zeros(length(track),2);
        
        %Copy the aforementioned properties into their respective matrix.
        MSD_pool(:,1) = MSD;
        frameLimPool(1,:) = frame_lim(1,:);
        LineLimits(1,1:2) = xline;
        LineLimits(1,3:4) = yline;
        Tracks(:,1) = track(:,1); Tracks(:,2)=track(:,2);
    else
        no_tracks = size(MSD_pool);
        %Compute the MSD based on the above fit
        [t,MSD] = MSD_single(track,9,0.077);
        t = transpose(t);
        MSD_pool(:,no_tracks(1,2)+1) = MSD;
        
        s_frameLimPool = size(frameLimPool);
        frameLimPool(s_frameLimPool(1,1)+1,:) = frame_lim(1,:);
        
        s_LineLimits = size(LineLimits);
        LineLimits(s_LineLimits(1,1)+1,1:2) = xline;
        LineLimits(s_LineLimits(1,1)+1,3:4) = yline;
        
        s_track = size(track);
        Tracks(:,s_track(1,2)+1) = track(:,1);
        Tracks(:,s_track(1,2)+2) = track(:,2);
        
    end
else
end

clear choice frame_lim gaussFit lastfit MSD profile p track...
    xline yline