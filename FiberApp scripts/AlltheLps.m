% Script written by Henry Cox 01/2017
% Script performs post processing on data from FiberApp (run
% ImageDatatoStruct.m first). Calculates the persistence length in two ways
% (mean curvature, end to end distance) and spits out the results as well
% as updating the Images structure. Requires End2endLp.m and Lpcurvature.m

% create variables to be calculated
% end-to-end distance, contour length, persistence length
end2end = [];
Lcs = [];
Lps = [];
Us = [];
es = [];
xU = [];

% loop through all images and fibrils
for i = 1:length(Images)
    disp(['Image ' num2str(i)]);
    
    if isempty(Images(i).xy_nm)
        Images(i).xy_nm = Images(i).xy;
    end
    
    ixy = Images(i).xy_nm;
    clear iend2end icurvature iLp iU ie
    for j = 1:length(Images(i).xy_nm)
        Images(i).xy_nm{j} = Images(i).xy_nm{j};
        % extract x y co-ordinates of fibril
        xpts = ixy{j}(1,:);
        ypts = ixy{j}(2,:);
        pts = [xpts', ypts'];
        Lc = calc_Lc(xpts,ypts);
        Images(i).length_nm(j) = Lc;
        
        % calculate end to end distance for the fibril
        iend2end(j) = sqrt((xpts(1)-xpts(end)).^2+(ypts(1)-ypts(end)).^2);
        
        % calculate persistence length using curvature from fibril
        %[Lp,k] = LpCurvature(xpts,ypts);
        %icurvature{j} = k;
        %iLp(j) = singleFibrilE2E(ixy{j},500);
        if  Lc > 8000
            xlen = length(xpts);
            xp1 = xpts(1:floor(xlen/2));
            xp2 = xpts(floor(xlen/2):end);
            yp1 = ypts(1:floor(xlen/2));
            yp2 = ypts(floor(xlen/2):end);
            [Ut,~] = bendenergy(xp1,yp1,25);
            xU = [xU, Ut];
            [Ut,~] = bendenergy(xp2,yp2,25);
            xU = [xU, Ut];
        end
        [iU(j),ie(j)] = bendenergy(xpts,ypts,25);
        xU = [xU, iU(j)];
    end
    

%    Images(i).curvature = icurvature;
    Images(i).end2end = iend2end;
    %Images(i).Lp = iLp;
    Images(i).U = iU;
    % extract data from this image
    end2end = [end2end, Images(i).end2end];
    Lcs = [Lcs, Images(i).length_nm];
    %Lps = [Lps, Images(i).Lp];
    Us = [Us, iU];
    es = [es, ie];
end

% sort all results by contour length
%[Lcs,I]=sort(Lcs);
%end2end = end2end(I);
%Lps = Lps(I);
%Lps(Lps == Inf) = [];

% Find persistence length from average persistence length from each fibril
%CurvLp = [nanmean(Lps),nanstd(Lps)];

% calculate persistence length using end to end method
%[E2ELp] = End2endLp(Lcs,end2end);


% Plot results
%{
figure
histogram(Lps,30,'Normalization','probability')
hold on
plot([E2ELp(1),E2ELp(1)],[0,0.3])
%}
clear Lp k xpts ypts i j I pts