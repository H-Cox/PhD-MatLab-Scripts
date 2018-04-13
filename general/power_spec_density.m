function power_spec_density(Data, fps)

Fs = fps;
x = Data;

N = length(x);

xdft = fft(x);
xdft = xdft(1:N/2+1);
psdx = (1/(Fs*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:Fs/length(x):Fs/2;
figure
plot(freq,10*log10(psdx))
grid on
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')

end