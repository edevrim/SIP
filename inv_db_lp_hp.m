function a22 = inv_db_lp_hp(C, N, iter)

%C is de decomposed signal as [a_last b_last b_last-1 b_last-2... b_1]
%C must be horizontal
%N is the DB filter type 
%iter is the number of iterations 
%x_original is the original signal 

%filter
f = dbfilter(N); 
Lp = sqrt(2)*f; %coefficients are sqrt2 times f
Hp =[]; %initialize

%Highpass flips
for k=1:2 * N 
    Hp(k) = Lp(2 * N - k + 1) * (-1) ^ (k+1);
end 

Lp2 = fliplr(Lp); %to use in matrix in reverse order 
Hp2 = fliplr(Hp); %to use in matrix in reverse order 

%*****************
% %Joel's conditions 
% % We start by determining the lengths of the signal S and the filter F.
% sze =size(C,1);
% if(sze==1)
%     C=C';
%     sze=size(C,1);
% end
% len=length(Lp);
% s = C;
% 
% % Check some conditions
% if(rem(log2(sze),1)~=0) 
%     error('Length of the input signal should be a power of 2');
% else
%     s=[s; zeros(2^ceil(log2(sze))-sze,size(s,2))]; %creates mxm matrix 
%     sze=size(s,1);
% end
% if(size(s,2)~=1)%image
%     if(rem(log2(size(s,2)),1)~=0)
%         s=[s zeros(size(s,1),2^ceil(log2(size(s,2)))-size(s,2))];
%     end
% end
% if(sze<len)
%     error('Length of the input signal should at least be as long as the length of the filter');
% end
% if(len~=length(Hp))
%     error('Low-pass and high-pass filter should have the same length');
% end
% if(floor(len/2)<(s/2))
%     error('Filter lengths should be even');
% end

%*****************

C=C'; %MAKE IT HORIZONTAL AGAIN
%initialize
%a22 = []; %initialize
%b22 = [];%initialize
[row1,len] = size(C); %be careful rows and columns numbers

%iterations 
for k=1:iter
    if k == 1
        a22 = C(1 : len / (2^(iter-k+1))); %from small to big
    else a22 = a22;
    end
    b22 = C(len / (2^(iter-k+1)) + 1 : 2*(len/ (2^(iter-k+1)) )); 
    x22 = cat(2, a22, b22);
    
    %first find DB matrix then take the inverse
    nn = length(x22); %for for loops 
   
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
    W_final = cat(1,W1D,W2D);
    
    W_inv = inv(W_final); %Inverse matrix
    %W_tra = W_final'; Works!
    
    a22 = (W_inv * x22')'; %make it horizontal again    
end

end



