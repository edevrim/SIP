function db_image = db_lp_hp_img(image, N, iter)
%image is given image
%N is DB type
%iter is the number of decomposition

figure
subplot(1,2,1);
imagesc(image)
colormap gray; 
axis image

[m, n] = size(image);

%DB filters
f = dbfilter(N);
Lp = sqrt(2)*f; %coefficients are sqrt2 times f
Hp =[]; 

for k=1:2 * N 
    Hp(k) = Lp(2 * N - k + 1) * (-1) ^ (k+1);
end 

Lp2 = fliplr(Lp); %to use in matrix in reverse order 
Hp2 = fliplr(Hp); %to use in matrix in reverse order 


%Building Lpass and hpass matrices 
%Image might be rectangle
W1M = zeros(m, m); %initialize lowpass row based
W2M = zeros(m, m); %initialize highpass row based

W1N = zeros(n, n); %initialize lowpass column based
W2N = zeros(n, n); %initialize highpass column based

%row based 
%this is for Lowpass before downsampling
for i=1:m
    for j=1:m 
        if j + 2*N > i && j - 1 < i 
            W1M(j,i) = Lp2(i-j+1);
            if j > (m - 2*N) + 1 
                for k=1:j - m + 2*N - 1
                    W1M(j, k) = Lp2(m-j+k+1);
                end
            end
        end
    end
end

    %this is for Highpass before downsampling
for i=1:m
    for j=1:m
        if j + 2*N > i && j - 1 < i 
            W2M(j,i) = Hp2(i-j+1);
            if j > (m - 2*N) + 1 
                for k=1:j - m + 2*N - 1
                    W2M(j, k) = Hp2(m-j+k+1);
                end
            end
        end
    end
end

W1M1 = downsample(W1M,2); %Downsampled then merged
W2M2 = downsample(W2M,2);
W_final_M = cat(1,W1M1,W2M2); %concated vertically (LP - HP)

%*********************************************************************
%column based 
%this is for Lowpass before downsampling
for i=1:n
    for j=1:n 
        if j + 2*N > i && j - 1 < i 
            W1N(j,i) = Lp2(i-j+1);
            if j > (n - 2*N) + 1 
                for k=1:j - n + 2*N - 1
                    W1N(j, k) = Lp2(n-j+k+1);
                end
            end
        end
    end
end

    %this is for Highpass before downsampling
for i=1:n
    for j=1:n
        if j + 2*N > i && j - 1 < i 
            W2N(j,i) = Hp2(i-j+1);
            if j > (n - 2*N) + 1 
                for k=1:j - n + 2*N - 1
                    W2N(j, k) = Hp2(n-j+k+1);
                end
            end
        end
    end
end

W1N1 = downsample(W1N,2); %Downsampled then merged
W2N2 = downsample(W2N,2);
W_final_N = cat(1,W1N1,W2N2); %concated vertically (LP - HP)

%iterations
for t=1:iter
    db_image = W_final_M * image * W_final_N';
    image = db_image;
end

subplot(1,2,2);
imagesc(db_image)
colormap gray; 
axis image

end

