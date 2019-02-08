%{
%Id numbers for various groups of fibrils from initial dynamics paper
freeID = [106,107,108,109,110,111,113,114,117];

allid = [1,3,4,5,6,7,8,9,10,11,12,13,43,44,45,46,47,52,53,54,55,56,57,...
    61,62,63,64,65,66,67,68,69,73,77,79,80,81,84,92,94,95,96,118,121,...
    122,123,124,126,127];
goodid = [1,3,4,5,6,7,8,9,10,12,43,44,46,47,52,55,56,57,62,64,68,69,77,...
        79,80,81,84,92,94,95,118,121,122,123,124,127];
%}


%{
I3K/pNIPAM
18-05-17
1.1 cold - id = [1,2,4,5,6,7,8,9,10,11,12];
1.2 cold - id = [1,2,3,4,5,6,7,9,10,11,12,13,14,15];
1.3 cold - id = [1,2,4,5,6,7,9,10,11,12,13,15];
1.4 cold - id = [1,2,3,4,5,6,7,8,9,10,11,12,13];
18-05-19
1.1 hot - id = [1,2,3,4,6,7,8,9,10,11,13];
1.2 hot - id = [1,2,3,4,5,6,7,8,9,10];
1.3 hot - id = [1,2,3,4,5,6,7,8,9,10,11,12,13,14];
1.4 hot - id = [1,2,4,5,6,7,8,9,10,11,12];
18-05-31
3.1 cold - id = [1,3,4,5,6,7,8,9,10,12,13,14];
3.2 cold - id = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18];
3.3 cold - id = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,16,17,19];
3.4 cold - id = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18];
3.1 hot - id = [1,3,4,5,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23];
3.2 hot - id = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23];
3.3 hot - id = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28];
3.4 hot - id = [1,2,3,4,5,6,7,8,9,10,11,13,15,18];

%}
%clear all

savenames = {'0p cold';
    '1p cold';
    '8p cold';
    '64p cold';
    '0p hot';
    '1p hot';
    '8p hot';
    '64p hot';
    };

savepath = 'C:\Users\mbcx9hc4\Dropbox (The University of Manchester)\MATLAB\18-11\22 - ';

bins = 0:0.1:30;
x = bins(1:end-1)+0.05;

acounts = zeros([8,length(x)]);

tDistFit = @(b,x)(tDist(x,b(1),b(2),b(3)));

 
for s = 1:8
    
    filename = [savepath savenames{s}];
    
    load(filename,'allNdc');
    
    ndc = [];
    
    for n = 1:length(allNdc)
        
        ndc = [ndc; allNdc{n}(:)];
        
    end
    
    [acounts(s,:), ~] = histcounts(abs(ndc),bins,'Normalization','pdf');
    
    %afitT(s) = nlinfit2(x,counts(s,:),tDistFit,[0,1,1]);
    %afitN(s) = FitGaussianHistogram(ndc,bins);
    
    
end


% 23/11/18
%{

ID = {[1,2,4,5,6,7,8,9,10,11,12];
    [1,2,3,4,5,6,7,9,10,11,12,13,14,15];
    [1,2,4,5,6,7,9,10,11,12,13,15];
    [1,2,3,4,5,6,7,8,9,10,11,12,13];
    
    [1,2,3,4,6,7,8,9,10,13];
    [1,2,3,4,5,6,7,8,9,10];
    [1,2,3,4,5,6,7,8,9,10,11,12,13,14];
    [1,2,4,5,6,7,8,9,10,11,12];
    
    [1,3,4,5,6,7,8,9,10,12,13,14];
    [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17];
    [1,2,3,4,5,6,7,8,9,10,11,12,13,14,16,17,19];
    [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18];
    
    [1,3,4,5,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23];
    [1,2,3,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23];
    [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28];
    [1,2,3,4,5,6,7,8,9,10,11,13,15,18];
    };

modeID = {[1,4,5,8,9,11];
    [1,2,3,4,5,6,7,9,10,13,14];
    [1,2,5,6,7,9,10,11,12,13,15];
    [2,3,4,5,7,8,9,10,12];
    
    [1,2,3,4,6,7,8,9,10,13];
    [1,2,3,4,5,6,7,8,9,10];
    [1,2,3,4,5,6,7,8,9,10,11,12,13,14];
    [1,2,4,5,6,7,8,9,10,11,12];
    
    [1,4,9,12,13,14];
    [1,3,5,6,8,10,11,12,13,14,15,16,17];
    [1,2,3,5,10,11,12,13,14,16,17,19];
    [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18];
    
    [1,3,4,5,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23];
    [1,2,3,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23];
    [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28];
    [1,2,3,4,5,6,7,8,9,10,11,13,15,18];
    };

names = {'Cold vids\18-05-17 1.1\';
    'Cold vids\18-05-17 1.2\';
    'Cold vids\18-05-17 1.3\';
    'Cold vids\18-05-17 1.4\';
    
    'Hot vids\18-05-19 1.1\';
    'Hot vids\18-05-19 1.2\';
    'Hot vids\18-05-19 1.3\';
    'Hot vids\18-05-19 1.4\';
    
    'Cold vids\18-05-31 3.1\';
    'Cold vids\18-05-31 3.2\';
    'Cold vids\18-05-31 3.3\';
    'Cold vids\18-05-31 3.4\';
    
    'Hot vids\18-05-31 3.1\';
    'Hot vids\18-05-31 3.2\';
    'Hot vids\18-05-31 3.3\';
    'Hot vids\18-05-31 3.4\';
    };

savenames = {'0p cold';
    '1p cold';
    '8p cold';
    '64p cold';
    '0p hot';
    '1p hot';
    '8p hot';
    '64p hot';
    };

homepath = 'C:\Users\mbcx9hc4\Dropbox (The University of Manchester)\Data\I3K NIPAM Dynamics\';
savepath = 'C:\Users\mbcx9hc4\Dropbox (The University of Manchester)\MATLAB\18-11\22 - ';
for s = 1:length(savenames)
    
    fibril_ids1 = modeID{s};
    fibril_ids2 = modeID{s+8};
    
    samplepath1 = names{s};
    samplepath2 = names{s+8};
      
    path = [homepath samplepath1];
    disp(path);
    allNdc = cell([1,length(fibril_ids1)+length(fibril_ids2)]);
    data = cell([1,length(fibril_ids1)+length(fibril_ids2)]);
    parfor f = 1:length(fibril_ids1)
        disp(['Fibril number ' num2str(f) ', id ' num2str(fibril_ids1(f))]);
        [output,ndc] = getVelocityCDF(fibril_ids1(f),path);
        
        data{f} = output;
        allNdc{f} = ndc;
        
    end
    lf1 = length(fibril_ids1);
    path = [homepath samplepath2];
    disp(path);
    parfor f = 1:length(fibril_ids2)
        
        disp(['Fibril number ' num2str(f) ', id ' num2str(fibril_ids2(f))]);
        [output,ndc] = getVelocityCDF(fibril_ids2(f),path);
        
        data{f+lf1} = output;
        allNdc{f+lf1} = ndc;
        
    end
    
    savefile = [savepath savenames{s} '.mat'];
    
    dataStruct = [data{:}];
    
    save(savefile,'data','allNdc','dataStruct');
    
    clear data allNdc dataStruct
    
end

function [cdfData,ndc] = getVelocityCDF(id,path)

    filename = [path 'fibril' num2str(id) '.mat'];
    load(filename,'c2','Lcval','s','new_s');
    
    disp(['Working on ' num2str(id)]);
    
    nc = convertToNewX2D(s,c2,new_s);
    
    disp(['Converted ' num2str(id)]);
    
    ndc = diff(nc')'./0.01;
    
    [cd, xvals] = ecdf(ndc(:));
    
    [acd, ax] = ecdf(abs(ndc(:)));
    
    cdfData.cdf = cd;
    cdfData.xcdf = xvals;
    cdfData.abscdf = acd;
    cdfData.absx = ax;

end



function importAndSavePotential(id, path, savepath, number)
try
    filename = [path 'fibril' num2str(id) '.mat'];
    load(filename,'c2','Lcval');
    if ~exist('c2','var')
        disp(['Correcting fibril ' num2str(id)]);
        correctFibrilWidths(id, path)
        load(filename,'c2','Lcval');
    end
    [~,~,~,surf_fig] = plot_potential(c2,Lcval);
    saveas(surf_fig,[savepath '-' num2str(number) '-' num2str(id) '.jpg'],'jpg');
    close all
catch
    disp(['Error on fibril ' num2str(id)]);
end
end



function correctWidths(id, path)
try
    filename = [path 'fibril' num2str(id) '.mat'];
    load(filename);
    
    fx = HenryMethod(fxdata);
    fy = HenryMethod(fydata);
    
    [fx,fy] = correctFxFy(fx,fy);
    
    c2 = JFilamentperpm(fx,fy,relax_x,relax_y);
    [data] = fit_potential(c2);
    w = data.width;
    [~,~,~,surf_fig] = plot_potential(c2,Lcval);
    saveas(surf_fig,[path 'fig_' num2str(id) '_2.jpg'],'jpg');
    close all
    save([path 'fibril' num2str(id) '.mat']);
catch
    disp(['ERROR ON FIBRIL ' num2str(id)])
    close all
end
end

function [output] = basicImport(id,path)

filename = [path 'fibril' num2str(id) '.mat'];
load(filename,'plateaus','Lcval','nmax');

q = (1:nmax).*pi()./Lcval;

output = [q', plateaus];


end


function [width, correctedWidth,s] = tubeWidths(id)

path = 'C:\Users\mbcx9hc4\Dropbox (The University of Manchester)\Data\I3K NIPAM Dynamics\';
filename = [path 'Fibril data\' num2str(id) '.mat'];
load(filename,'fxdata','fydata','relax_x','relax_y','w','Lcval');
width = w;
s = linspace(0,Lcval,1001);
new_s = 0:0.05:round(Lcval,1);
correctedWidth = convertToNewX(s,w,new_s);

sdfile = 'C:\Users\mbcx9hc4\Dropbox (The University of Manchester)\MATLAB\18-04\26 - sd 2.mat';
load(sdfile,'sd','All')

video_id = All(All(:,1)==id,2);
drift = sd{video_id(1)}';
fx = HenryMethod(fxdata);
fy = HenryMethod(fydata);
fx = fx-drift(1,1:size(fx,2));
fy = fy-drift(2,1:size(fx,2));

c = JFilamentperpm(fx,fy,relax_x,relax_y);

[data] = fit_potential(c);
correctedWidth = data.width;


end

function process_fibril(id)
path = 'C:\Users\mbcx9hc4\Dropbox (The University of Manchester)\Data\I3K NIPAM Dynamics\Hot vids\18-05-31 3.4\';
filename = [path 's' num2str(id) '.txt'];
try
    % basic fitting
    JFilImport;
    FourierDecompose;
    [c] = JFilamentperpm(fxdata,fydata,relax_x,relax_y);
    [m] = FMode2MSD(a,1);
    [plateaus] = MSDPlateau(m);
    [data] = fit_potential(c);
    w = data.width;
    s = linspace(0,Lcval,1001);
    
    % normalise widths
    new_s = 0:0.05:round(Lcval,1);
    normalWidth = convertToNewX(s,w,new_s);
    %{
        % drift corrected widths
        sdfile = 'C:\Users\mbcx9hc4\Dropbox (The University of Manchester)\MATLAB\18-04\26 - sd 2.mat';
        load(sdfile,'sd','All')
        video_id = All(All(:,1)==id,2);
        drift = sd{video_id(1)}';
        fx = HenryMethod(fxdata);
        fy = HenryMethod(fydata);
        fx = fx-drift(1,1:size(fx,2));
        fy = fy-drift(2,1:size(fx,2));
        c2 = JFilamentperpm(fx,fy,relax_x,relax_y);
        [data2] = fit_potential(c2);
        correctedWidth = data2.width;
        normalCWidth = convertToNewX(s,correctedWidth,new_s);
    %}
    save([path 'fibril' num2str(id) '.mat']);
    
catch
    disp(['ERROR ON FIBRIL ' num2str(id)])
end
end
%}


% 22/11/18

%{

for s = 1%length(savenames)
    
    fibril_ids1 = modeID{s};
    fibril_ids2 = modeID{s+8};
    
    samplepath1 = names{s};
    samplepath2 = names{s+8};
      
    path = [homepath samplepath1];
    disp(path);
    figure;
    data = [];
    for f = 1:length(fibril_ids1)
        disp(['Fibril number ' num2str(f) ', id ' num2str(fibril_ids1(f))]);
        [output] = basicImport(fibril_ids1(f),path);
        hold on;
        plot(output(:,1),output(:,2),'.');
        data = [data; output];
    end
    
    path = [homepath samplepath2];
    disp(path);
    for f = 1:length(fibril_ids2)
        disp(['Fibril number ' num2str(f) ', id ' num2str(fibril_ids2(f))]);
        [output] = basicImport(fibril_ids2(f),path);
        hold on;
        plot(output(:,1),output(:,2),'.');
        data = [data; output];
    end

end
%}

% 30/10/2-18
%{
savenames = {'0p cold';
    '1p cold';
    '8p cold';
    '64p cold';
    '0p hot';
    '1p hot';
    '8p hot';
    '64p hot';
    };

homepath = 'C:\Users\mbcx9hc4\Dropbox (The University of Manchester)\Data\I3K NIPAM Dynamics\';
allw = {};
for s = 1:length(savenames)
    
    fibril_ids1 = ID{s};
    fibril_ids2 = ID{s+8};
    
    samplepath1 = names{s};
    samplepath2 = names{s+8};
    
    savepath = [homepath 'Heatmaps/highqual ' savenames{s}];
    
    path = [homepath samplepath1];
    disp(path);
    parfor f = 1:length(fibril_ids1)
        disp(['Fibril number ' num2str(f) ', id ' num2str(fibril_ids1(f))]);
        importAndSavePotential(fibril_ids1(f), path, savepath, f);
    end
    
    path = [homepath samplepath2];
    disp(path);
    parfor f = 1:length(fibril_ids2)
        
        disp(['Fibril number ' num2str(f) ', id ' num2str(fibril_ids2(f))]);
        importAndSavePotential(fibril_ids2(f), path, savepath, f+length(fibril_ids1));
    end
    
end
%}


% 25/10/2018
%{
homepath = 'C:\Users\mbcx9hc4\Dropbox (The University of Manchester)\Data\I3K NIPAM Dynamics\Heatmaps\';
allw = {};
for s = 1:length(names)
    
    w = [];
    fibril_ids = ID{s};
    
    samplepath = names{s};
    
    disp(samplepath);
    
    path = [homepath samplepath];
    for f = 1:length(fibril_ids)
        disp(['Fibril number ' num2str(f) ', id ' num2str(fibril_ids(f))]);
        %process_fibril(fibril_ids(f));
        %correctWidths(fibril_ids(f), path)
        [tempW] = basicImport(fibril_ids(f),path);
        w = [w; tempW];
       
    end
    allw = [allw, w];
end
%}

% 22/10/2018
%{
function [correctedWidth] = basicImport(id,path)

    filename = [path 'fibril' num2str(id) '.mat'];
    load(filename,'w','s','Lcval');
    
    new_s = 0:0.05:round(Lcval,1);
    correctedWidth = convertToNewX(s,w,new_s);
    
    %correctedWidth = nanmean(w(:));
end
%}

% 30/04
%{
for t = 2:7
    disp(t);
    fibril_ids = All(All(:,2)==t,1);
%{
    p{t} = [];
    q{t} = [];
    cw{t} = [];
%}
    parfor f = 1:length(fibril_ids)
        process_fibril(fibril_ids(f));
%{
        [tempP, tempQ] = basicImport(fibril_ids(f));
        p{t} = [p{t}; tempP];
        q{t} = [q{t}; tempQ];
        [width, correctedWidth,s] = tubeWidths(fibril_ids(f));
        cw{t} = [cw{t}; correctedWidth'];
%}
    end
        
    
end
%}

% 26/04
%{
clearvars -except T27 T29 T31 T33 T35 T37 T272 Tid

for temp = 3:length(Tid)
    disp(['On temp ' num2str(temp) ' of ' num2str(length(Tid))]);
    this_temp = Tid{temp};
    parfor fib = 1:length(this_temp)
        
        process_fibril(this_temp(fib));
    end
    
end

%}

% old functions used for dynamics paper
%{
function [q,tau] = relaxtions(id)
path = 'C:\Users\mbcx9hc4\Dropbox (The University of Manchester)\paper 2\Fibrils\';
load([path num2str(id) '.mat']);

m = FMode2MSD(a);

try
    plat = MSDPlateau(m);
catch
    plat = m(100,:);
end

q = (1:25)'.*pi()./Lcval;
ltaufit =  @(b,x)log(b(1).*(1-exp(-x./b(2))));
t = taugen(100,100);
for i = 1:25
    try
        fit(i) = nlinfit2(t,log(m(1:100,i)),ltaufit,[plat(i),0.1]);
        tau(i,1:2) = fit(i).xo(2,1:2);
    catch
        tau(i,1:2) = [NaN, NaN];
    end
    
end
end

function [c,Lcval] = loadupc(id)
path = 'C:\Users\mbcx9hc4\Dropbox (The University of Manchester)\paper 2\Fibrils\17-10-02 2-1\';
load([path num2str(id) '.mat']);
FourierDecompose
[c] = JFilamentperpm(fxdata,fydata,relax_x,relax_y);
end

function [U,Uframe] = find_energies(id)
path = 'C:\Users\mbcx9hc4\Dropbox (The University of Manchester)\paper 2\Fibrils\';
load([path num2str(id) '.mat']);
npiL = (1:25)*pi/Lcval;
npiL = npiL';
npiLa = (npiL.*(a-amean)).^2;
npiLam = (npiL.*amean).^2;
U = sum(npiLam(npiL<1.2));
Uframe = sum(npiLa(npiL<1.2,:));

end

function [Uframe, q,npiL,nplateaus,fplateau,error] = find_energies2(id)
path = 'C:\Users\mbcx9hc4\Dropbox (The University of Manchester)\paper 2\Fibrils\';
load([path num2str(id) '.mat']);
[b] = Fourier2Normalmodes(a,Lcval);
[nm] = FMode2MSD(b,1);
[nplateaus] = MSDPlateau(nm);
[fm] = FMode2MSD(a,1);
[fplateau] = MSDPlateau(fm);
N = size(xdata,1);
try
    [error] = finderror(fplateau,Lcval,N);
catch
    error = NaN;
end
bmean = mean(b,2);
npiL = (1:25)*pi/Lcval;
npiL = npiL';
npiLa = (npiL.*(b-bmean)).^2;
%npiLam = (npiL.*amean).^2;
Uframe = npiLa;
q = repmat(npiL,[1,size(Uframe,2)]);
q = q(:);
Uframe = Uframe(:);
end

function [error] = finderror(fplateau,Lcval,N)
func = @(b,x)(b(1).*(1+(N-2).*sin(x.*pi()./(2.*(N-1))).^2));
n = 1:25;
q = n*pi/Lcval;
fitp = fplateau(q>1);
fit = nlinfit2(n(q>1),fitp,func);
error = sqrt(fit.xo(1,1).*Lcval./4);
end

function [plateaus, q, Lcval] = importMSDplats(id)
path = 'C:\Users\mbcx9hc4\Dropbox (The University of Manchester)\paper 2\Fibrils\';
load([path num2str(id) '.mat']);
JFil2Lp
end

function [com,mean_angle] = importComAngle(id)
path = 'C:\Users\mbcx9hc4\Dropbox (The University of Manchester)\paper 2\Fibrils\';
load([path num2str(id) '.mat']);
mean_angle = mean(ang);
end

function [x,y,com,mean_angle] = importforcrosslinks(id)
disp(id)
close all
path = 'C:\Users\mbcx9hc4\Dropbox (The University of Manchester)\MATLAB\Dynamic fibrils\Crosslinks\69';
filename = [path id ' track.txt'];
JFilImport;
JFilamentends
x = xdata;
y = ydata;
mean_angle = nanmean(tang(:));
save([path id '.mat']);
end

function [fitdata,Lcval] = fitMSDs(id)
disp(id)
close all
load(['C:\Users\mbcx9hc4\Dropbox (The University of Manchester)\paper 2\Fibrils\1-2 snakes\' num2str(id) '.mat']);
filename = [num2str(id) ' msd fit.png'];
[fitdata] = fitModeMSDs(a(:,1:500),filename);
end

function [correlation_data,U,xm,lags] = energycorrelate(id)
disp(id)
close all
load(['C:\Users\mbcx9hc4\Dropbox (The University of Manchester)\paper 2\Fibrils\' num2str(id) '.mat']);
U = modes2Energy(a);
U = normalise(U');
[xm,] = RotateTransform(com(:,1),com(:,2),-mean_angle);

if length(xm) > length(U)
    xm = xm(2:end);
end

xm = abs(normalise(xm));

[cor,la] = xcorr(xm,U,'coeff');

correlation_data = cor(la>=0);
lags = la(la>=0)';
lags = lags./100;

end

function [correlation_data,errors,lengthscales,lags] = timecorrelate(id)
disp(id)
close all
load(['C:\Users\mbcx9hc4\Dropbox (The University of Manchester)\paper 2\Fibrils\' num2str(id) '.mat']);
[data] = fit_potential(c);
w = data.width;
s = linspace(0,Lcval,1001);
cdata = c(w>0.05,:);
Lcval = range(s(w>0.05));
[correlation_data,errors] = MSD_like_correlation(cdata(1:30:end,:));
lengthscales = linspace(0,Lcval,size(correlation_data,1))';
lags = repmat(0:0.01:(size(correlation_data,2)-1)/100,[35,1]);

end

function potential_colourmap(id)
    disp(id)
    load(['C:\Users\mbcx9hc4\Dropbox (The University of Manchester)\MATLAB\Dynamic fibrils\8mM fibrils\Transverse\tfibdata ' num2str(id) '.mat']);
    close all
    [pd,x,y,surf_fig] = plot_potential(c,Lcval);
    saveas(surf_fig,['confining_potential ' num2str(id) '.png']);
    close all
end

function [cor, s,w,U] = tubecorrelate(id)
disp(id)
close all
load(['C:\Users\mbcx9hc4\Dropbox (The University of Manchester)\paper 2\Fibrils\' num2str(id) '.mat']);
[data] = fit_potential(c);
w = data.width;
s = linspace(0,Lcval,1001);
[co,la] = xcorr(w-mean(w),'coeff');
cor = co(la>=0);
n = 1:25;
U = sum((diff(relax_angle)./diff(relax_s)).^2);
end

function process_fibril(id)
path = 'C:\Users\mbcx9hc4\Dropbox (The University of Manchester)\paper 2\Fibrils\';
filename = [path num2str(id) ' - track.txt'];
JFilImport;
FourierDecompose;
[c] = JFilamentperpm(fxdata,fydata,relax_x,relax_y);
[m] = FMode2MSD(a,1);
[~,~,~,figure2] = plot_potential(c,Lcval);
pos = get(figure2,'position');
set(figure2,'position',[pos(1:2)/4 pos(3:4)*1.5])
saveas(figure2,['G:\Data\Super Resolution Microscopy\17-10-02\1 - snakes\T_Heat ' num2str(id) '.png'])
close all
clear VarName5 X Y c2
save([path num2str(id) '.mat']);
end

% works in parallel
function process_PP(id)
load(['fibdata ' num2str(id) '.mat']);
[PP,image] = FindPP(xyf);
save(['fibdata ' num2str(id) '.mat']);
close all
end

function make_images(id)

close all
load(['G:\Data\Super Resolution Microscopy\17-10-02\1-2 snakes\' num2str(id) '.mat']);
[~,~,~,figure2] = plot_potential(c,Lcval);
pos = get(figure2,'position');
set(figure2,'position',[pos(1:2)/4 pos(3:4)*1.5])
saveas(figure2,['G:\Data\Super Resolution Microscopy\17-10-02\1 - snakes\T_Heat2 ' num2str(id) '.png'])
close all
end

function [Lp,fits,s,w] = freeEnds(id,r1,r2,shift)
close all
load(['C:\Users\mbcx9hc4\Dropbox (The University of Manchester)\paper 2\Fibrils\1-2 snakes\' num2str(id) ' - done.mat']);
s = s(r1:end-r2)-shift;
w = w(r1:end-r2);
fits = fit;
Lp = fit.Lp(2);
end

%}

% 26/04
%{
qt = {};
taut = {};
parfor z = 1:length(goodid)

id = goodid(z);    disp(id);
[qt{z},taut{z}] = relaxtions(id);
end
q = [];
tau = [];

for z = 1:length(goodid)
    q = [q;qt{z}];
    tau = [tau; taut{z}];
end
%}

% 03/04
%{
parfor z = 1:length(goodid)
id = goodid(z);
[c{z},Lcval(z)] = loadupc(id);
end
C = {};
Cx = {};

for z = 1:3
    disp(z)
    l = length(C);
    for p = 1:4-z
        disp(p)
        [C{l+p}] = correlation_matrix([c{z}(:,1:2000);c{z+p}(:,1:2000)]);
        Cx{l+p} = C{z+p-1}(1011:10:end,1:10:991);
    end
end
%}

% 19/03
%{
parfor z = 1:length(goodid)
id = goodid(z);
[Uframe{z},q{z},npiL{z},plateaus{z},fplat{z},error(z)] = find_energies2(id);

end
Uf = [];
qf = [];
nf = [];
pf = [];
fp = [];
for z = 1:length(Uframe)
    Uf = [Uf;Uframe{z}];
    qf = [qf;q{z}];
    nf = [nf; npiL{z}];
    pf = [pf; plateaus{z}];
    fp = [fp; fplat{z}];
end
%}
% 01/03
%{
function [amean, npiL, Umean] = find_energies(id)
path = 'C:\Users\mbcx9hc4\Dropbox (The University of Manchester)\paper 2\Fibrils\';
load([path num2str(id) '.mat']);
npiL = (1:25)*pi/Lcval;
npiL = npiL';
npiLa = (npiL.*a).^2;
Us = cumsum(npiLa);
Us = Us./max(Us);
for i = 1:24
   Udiff(i,:) = Us(1+i,:)-Us(i,:);
end
Umean = nanmean(Udiff,2);
end
%}
% 24/01
%{
parfor z = 1:length(allid)
id = allid(z);
[cor{z}, s{z},w{z},U(z)] = tubecorrelate(id)
maxw(z) = max(w{z});
minw(z) = min(w{z});
meanw(z) = mean(w{z});
L(z) = max(s{z});
end

parfor z = 1:length(allid)
id = allid(z);
[com{z},mean_angle(z)] = importComAngle(id);
[xm{z},ym{z}] = RotateTransform(com{z}(:,1),com{z}(:,2),-mean_angle(z));
xmsd{z} = simpleMSD(xm{z});
ymsd{z} = simpleMSD(ym{z});
msd{z} = simpleMSD([xm{z},ym{z}]);
end
%}