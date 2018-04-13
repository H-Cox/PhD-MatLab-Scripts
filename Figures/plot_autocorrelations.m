function plot_autocorrelations(varargin)

flop_modes = varargin{1};
flop_modes = flop_modes(:,:,1);
[an,bn] = size(flop_modes);
an = min([an,bn]);
frames = length(flop_modes{1,1});

lags = 1:(frames-1)/2;

lags = [fliplr(-lags), 0 , lags];

if length(varargin) == 3
    
    a_choice = varargin{2};
    
    b_choice = varargin{3};
    
    fps = 100;
    
elseif length(varargin) == 4
    
    fps = ceil(varargin{4});
    
else
    a_choice = 1:an;
    b_choice = 1:bn;
    fps = 100;
end

lags = lags.*fps.^-1;

data = [];
names = {};
n = 1;
for k = a_choice
    
        data(n,:) = flop_modes{k,k};
        names{n} = [num2str(k) ' : ' num2str(k)];
        n = n + 1;
end

pltflopmds(lags,data,names);



