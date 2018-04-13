function [FFT,frequencies] = betterFFT(varargin)

X = varargin{1};
L = length(X);
if length(varargin) == 2
    sampling_freq = varargin{2};
else
    sampling_freq = 1;
end

Y = fft(X);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
FFT = P1;
frequencies = sampling_freq*(0:(L/2))/L;

end
