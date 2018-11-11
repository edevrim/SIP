function X = inv_wldecom(Y, N, c, d)
%Y is [a_last b_last b_last-1 b_last-2... b_1]
%c lowpass filter
%d highpass filter
%N number of decomposition 
%X Original signal

[row1,len] = size(Y); %be careful row and column numbers
a22 = Y(1 : len/2^N); %initialize
b22 = Y(len/2^N + 1 : 2*(len/2^N)); %initialize

a22 = []; 
b22 = [];
%deneme1

for i=1:N
    vector_size = len/2^(N-i + 1);
    for j=1:vector_size
        if i == 1 
            a22 = [a22 Y(j)]; 
        end
        b22 = [b22 Y(vector_size + j)];
    end
        x22 = idwlt(a22, b22, c, d); 
        a22 = x22; 
        b22 = [];
end

X = a22; 

end

