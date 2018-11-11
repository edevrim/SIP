function C = db_lp_hp(x, N, iter)
%x is the signal
%N is the Db type (1 if haar, 2 if 4 coefficients...)
%iter is the number of decompositions
%f is from dbfilter
%Lp and Hp filters for discrete wavelet transform
%C is the output (like wldecom)

f = dbfilter(N);
[m, n] = size(x);

Lp = sqrt(2)*f; %coefficients are sqrt2 times f
Hp =[]; 

for k=1:2 * N 
    Hp(k) = Lp(2 * N - k + 1) * (-1) ^ (k+1);
end 

%Building Lpass and hpass matrices 

Lp2 = fliplr(Lp); %to use in matrix in reverse order 
Hp2 = fliplr(Hp);
C = []; %fill the C 
init = x'; %just to save x 

for t=0:iter-1 %for each iteration find the matrix and fill the C
    
    nn = n/(2^t); %for for loops 
   
    W1 = zeros(nn, nn); %initialize lowpass
    W2 = zeros(nn, nn); %initialize highpass

    %this is for Lowpass before downsampling
    for i=1:nn
        for j=1:nn
            if j + 2*N > i && j - 1 < i 
                    W1(j,i) = Lp2(i-j+1);
                    if j > (nn - 2*N) + 1 
                        for k=1:j - nn + 2*N - 1
                        W1(j, k) = Lp2(nn-j+k+1);
                        end
                    end

            end
        end
    end

    %this is for Highpass before downsampling
    for i=1:nn
        for j=1:nn
            if j + 2*N > i && j - 1 < i 
                    W2(j,i) = Hp2(i-j+1);
                    if j > (nn - 2*N) + 1 
                        for k=1:j - nn + 2*N - 1
                        W2(j, k) = Hp2(nn-j+k+1);
                        end
                    end

            end
        end
    end

    W1D = downsample(W1,2); %Downsampled then merged
    W2D = downsample(W2,2);
    W_final = cat(1,W1D,W2D); %concated vertically (LP - HP)
    
    x_deb = (W_final * init); 
    a11 = x_deb(1: length(x_deb)/2);
    b11 = x_deb(length(x_deb)/2 + 1: length(x_deb));
    C = cat(1, b11, C); 
    init = a11;
end

C = cat(1, a11, C); 
end
