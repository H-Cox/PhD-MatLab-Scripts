function [projections] = project_eigvectors(correlation_matrix,data)

[n,~] = size(correlation_matrix);

if size(data,1) ~= n
    data = data';
end

[eigenvectors,D] = eig(correlation_matrix);

eigenvalues = diag(D);

[sorted_eval,I] = sort(eigenvalues,'descend');
sorted_evec = eigenvectors(:,I);

for k = 1:n
    
    projections(k,:) = sorted_evec(:,k)'*data;
end
end