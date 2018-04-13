function [fit, lifetimes] = Find_mode_lifetimes(mode_msds,plateaus)

[frames,number] = size(mode_msds);

framerate = 100;

[tau] = taugen(framerate,frames);

lifetimes = zeros(number,2);

for n = 1:number
    
    msd_model = @(b,x)log((1-exp(-x./b(1))))+log(b(2));%plateaus(n));
    
    fit(n) = nlinfit2(tau(1:100),log(mode_msds(1:100,n)),msd_model,[0.1,plateaus(n)]);
    
    lifetimes(n,:) = fit(n).xo(1:2);
end
end

