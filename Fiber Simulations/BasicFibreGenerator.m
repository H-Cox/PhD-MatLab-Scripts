% Script to generate fibrils for simultations


% define number of fibrils
n = 40;

% define length of fibrils
l = 250;

for i = 1:n
    
    input(i,:) = rand(250,1);
    
    fibres{i} = zeros(250,3);
    
    fibres{i}(input(i,:)<0.5,1) = 1;
    fibres{i}(input(i,:)>0.5,2) = 1;
    hold on 
    plot(fibres{i}(:,1))
end
