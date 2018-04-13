function [C] = correlation_matrix(input)

[row,~] = size(input);

C = zeros(row,row);

parfor i = 1:row
    for j = 1:row
        a = sqrt(nanmean(input(i,:).^2));
        b = sqrt(nanmean(input(j,:).^2));
        C(i,j) = nanmean(input(i,:).*input(j,:))./(a.*b);
    end
end
end