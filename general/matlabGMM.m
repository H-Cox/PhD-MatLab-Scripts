function [fit] = matlabGMM(inputData,numberOfClusters)

k = numberOfClusters;
X = inputData;

d = 5000;
x1 = linspace(min(X(:,1)) - 2,max(X(:,1)) + 2,d);
x2 = linspace(min(X(:,2)) - 2,max(X(:,2)) + 2,d);
[x1grid,x2grid] = meshgrid(x1,x2);
X0 = [x1grid(:) x2grid(:)];
threshold = sqrt(chi2inv(0.99,2));
options = statset('MaxIter',1000); % Increase number of EM iterations

figure;
gmfit = fitgmdist(X,k,'CovarianceType','full',...
        'Options',options);
clusterX = cluster(gmfit,X);
mahalDist = mahal(gmfit,X0);
h1 = gscatter(X(:,1),X(:,2),clusterX);
hold on;
nK = numel(unique(clusterX));
for m = 1:nK
        idx = mahalDist(:,m)<=threshold;
        Color = h1(m).Color*0.75 + -0.5*(h1(m).Color - 1);
        h2 = plot(X0(idx,1),X0(idx,2),'.','Color',Color,'MarkerSize',1);
        uistack(h2,'bottom');
end
plot(gmfit.mu(:,1),gmfit.mu(:,2),'kx','LineWidth',2,'MarkerSize',10)
hold off;

fit.gmfit = gmfit;

[fit] = findCollectiveProb(X,k,fit);

end



function [fit] = findCollectiveProb(data,k,fit)

data = log(data);

gridSize = 100;

for d = 1:2
    mind = min(data(:,d))-2;
    maxd = max(data(:,d))+2;
    
    fit.x(d,:) = linspace(mind(1),maxd(1),gridSize);
end

[fit.x,fit.y] = meshgrid(fit.x(1,:),fit.x(2,:));
    

fit.gridX = exp([fit.x(:), fit.y(:)]);
    
for c = 1:k
    z1(:,k) = gaussianND(fit.gridX, fit.gmfit.mu(k, :), fit.gmfit.Sigma(:,:,k));
end
    
z1 = nanmean(z1,2);
    
Z1 = reshape(z1, gridSize, gridSize);

fit.z = Z1;

end