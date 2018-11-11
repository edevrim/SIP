function [] = plotfft(fft, fs)

f1 = (0:length(fft)-1) * fs / length(fft); %makes the plot in 0 to 10 (fs) to see where the amplitude is 

%While the amplitude tells you how strong is a harmonic in a signal, the phase tells where this harmonic lies in time.

figure,
subplot(2, 1, 1);
plot(f1, abs(fft)) %abs function gives the magnitude (|a+ib|)
title('amplitutde spectrum')
subplot(2, 1, 2);
plot(f1, unwrap(angle(fft))) % angle gives the phase (loc) 
title('phase spectrum')%ge^iQ g 

end

