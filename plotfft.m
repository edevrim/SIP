function [] = plotfft(fft, fs)

f1 = (0:length(fft)-1) * fs / length(fft); 

figure,
subplot(2, 1, 1);
plot(f1, abs(fft)) %abs gives the magnitude (|a+ib|)
title('amplitutde spectrum')
subplot(2, 1, 2);
plot(f1, unwrap(angle(fft))) % angle gives the phase (loc) 
title('phase spectrum')%ge^iQ g 

end

