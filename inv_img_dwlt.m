function img_org = inv_img_dwlt(Y, N)
%Y is haared N times 
%img_org original image 

[m, n] = size(Y); 

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


W_final = cat(1,W1,W2); %concated vertically 

for k=1:N 
    img_org = W_final' * Y * W_final;
    Y = img_org;
end

end
