%% WLDECOM
%  Calculates the wavelet decomposition of the signal x for N scales using
%  low-pass filter c and high-pass filter d.
%  The output C is a vector of the form [a^{j-N},b^{j-N},...,b^{j-1}],
%  where a^{j-N} are the finest approximation coeficients, b^{j-1} are the
%  coarsest detail coefficients and a^j=x. 

%first (the one we get at last!) b is coarsest!!!!@#@#!@#!!!! 

function C = wldecom(x,N,c,d) 

[a, b] = dwlt(x,c,d); 
init = a; 
C = [b];

for i=1:(N - 1)
    [a1, b1] = dwlt(init,c,d);
    init = a1; 
    C = [b1 C]; 
end 

C = [init C]; 
