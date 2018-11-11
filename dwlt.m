%% DWLT
%  Calculates the wavelet transform of x with low-pass filter c and
%  high-pass filter d. x is assumed to be divisible by 2.
function [a,b] = dwlt(x,c,d)

c = [1/sqrt(2), 1/sqrt(2)]; 
d = [1/sqrt(2), -1/sqrt(2)]; %in the book

a = filter(c,1,x);
a = a(2:2:length(a));
b = filter(d,1,x);
b = b(2:2:length(b));

end


