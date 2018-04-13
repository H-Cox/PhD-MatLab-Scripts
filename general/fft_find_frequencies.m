function fft_find_frequencies(data,fps)

y = data;
N = length(y);
Y = fft(y,N)/N;

f = fps/2*linspace(0,1,round(N/2)+1);
figure;
plot(f,2*abs(Y(1:round(N/2)+1)))

end