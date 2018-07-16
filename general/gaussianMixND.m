function [fit] = gaussianMixND(data,k)


[m, n] = size(data);

indices = randperm(m);
mu = data(indices(1:k), :);

sigma = [];

for j = 1:k
    sigma{j} = cov(data);
end

weights = ones(1, k) * (1 / k);

W = zeros(m, k);

diff = 1;

while diff > 0.001
    
    r = zeros(m, k);
    
    for j = 1:k
        % Evaluate the Gaussian for all data points for cluster 'j'.
        r(:, j) = gaussian(data, mu(j, :), sigma{j});
    end
    
    r_w = bsxfun(@times, r, weights);
    
    W = bsxfun(@rdivide, r_w, sum(r_w, 2));
    
    prevMu = mu;
    
    for j = 1:k
    
        % Calculate the prior probability for cluster 'j'.
        weights(j) = mean(W(:, j), 1);
        
        % Calculate the new mean for cluster 'j' by taking the weighted
        % average of all data points.
        mu(j, :) = weightedAverage(W(:, j), data);

        % Calculate the covariance matrix for cluster 'j' by taking the 
        % weighted average of the covariance for each training example. 
        
        sigma_k = zeros(n, n);
        
        % Subtract the cluster mean from all data points.
        Xm = bsxfun(@minus, data, mu(j, :));
        
        % Calculate the contribution of each training example to the covariance matrix.
        for (i = 1 : m)
            sigma_k = sigma_k + (W(i, j) .* (Xm(i, :)' * Xm(i, :)));
        end
        
        % Divide by the sum of weights.
        sigma{j} = sigma_k ./ sum(W(:, j));
    end
    
    diff = abs(sum(mu(:)-prevMu(:)));
    
end


fit.mean = mu;
fit.sigma = sigma;

gridSize = 100;

for d = 1:n
    mind = min(data(:,d));
    maxd = max(data(:,d));
    
    fit.x(d,:) = linspace(mind(1),maxd(1),gridSize);
end

if n == 2
    [fit.x,fit.y] = meshgrid(fit.x(1,:),fit.x(2,:));
    fit.gridX = [fit.x(:), fit.y(:)];
else
    fit.gridX = fit.x;
end

for c = 1:k
    z1(:,k) = gaussian(fit.gridX, mu(k, :), sigma{k});
end
    
z1 = nanmean(z1,2);

if n == 2
    z1 = reshape(z1, gridSize, gridSize);
end

fit.z = z1;

end
    