%% img_dwlt
function haared_img = img_dwlt(x, N) %works for multi Haar as well

%Haar in Images
% c and d set as in the dwlt
%x is image 
%N number of decomposition

[m, n] = size(x); 
x = double(x); %make it double

W1 = zeros(m/2,n); %initialize 
W2 = zeros(m/2,n); %initialize

for i=1:n
    for j=1:m/2
        if 2*j >= i && 2*j -2 < i 
                W1(j,i) = 1/sqrt(2); 
                if mod((i), 2) == 1 
                    W2(j,i) = 1/sqrt(2); 
                else W2(j,i) = -1/sqrt(2); 
                end
        end
    end
end

W_final = cat(1,W1,W2); %concated vertically (ust alta) 

%Iterations! 
for k=1:N 
    haared_img = W_final * x * W_final';
    x = haared_img; 
end

end
