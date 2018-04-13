function [data] = too_many_columns(test)
[row,col] = size(test);

frames = 1500;

reductionfactor  = col/frames;

data = zeros(row*reductionfactor,frames);

for n = 1:reductionfactor
    
    data((n-1)*row+1:n*row,:) = test(:,(n-1)*frames+1:n*frames);
end
end