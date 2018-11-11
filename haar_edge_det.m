function edges = haar_edge_det(image, iter, alpha)

%Automatic threshold technique with Haar
%iter is number of iterations 
%alpha is set as 1 in the book

%image = double(foo);

haared = db_lp_hp_img(image,1,iter); %Haar one times - image must be double

% figure
% title('Edges')
% subplot(2,2,1);
% imagesc(image)
% colormap gray; 
% axis image
% 
% subplot(2,2,2);
% imagesc(haared)
% colormap gray; 
% % axis image

S = haared; %that we work on in threshold I divided
%Only take values in the V,H,D for S (exclude B)

[m, n] = size(haared);
b_m = m / 2^iter; 
b_n = n / 2^iter; 

%Set all elements of B to 0 
for k=1:b_m 
    for j=1:b_n
        S(k,j) = 0; 
    end
end

%Finding min-max of V,D,F
max1 = -10000; 
min1 = 10000;
max2 = -10000; 
min2 = 10000;

for i=(b_m + 1):m 
    for j=1:n 
        if abs(S(i,j)) >= max1
            max1 = abs(S(i,j));
        end
    end
end

for i=1:m 
    for j=(b_n+1):n 
        if abs(S(i,j)) >= max2
            max2 = abs(S(i,j));
        end
    end
end

for i=(b_m + 1):m 
    for j=1:n 
        if abs(S(i,j)) < min1
            min1 = abs(S(i,j));
        end
    end
end

for i=1:m 
    for j=(b_n+1):n  
        if abs(S(i,j)) < min2
            min2 = abs(S(i,j));
        end
    end
end

max11 = max(max1, max2); 
min11 = min(min1, min2);

%Finding threshold 
T1 = (max11 + min11) /2; %initial threshold 
T2 = 0; %initialize
diff = alpha + 1; %initialize

while diff >= alpha
    S_small = S(S < T1); 
    S_big = S(S >= T1); 
    T2 = (mean(S_small) + mean(S_big)) / 2;
    diff = abs(T2 - T1);
    T1 = T2;
end
%We found the threshold 

%Edge detection 
%Now edge detecting 

for i=(b_m + 1):m %convert all elements in V, H, and D to 0 if it's under the threshold
    for j=1:n
        if S(i,j) < T2 
            S(i,j) = 0;
        end
    end
end

for i=1:m %convert all elements in V, H, and D to 0 if it's under the threshold
    for j=(b_n + 1):n
        if S(i,j) < T2 
            S(i,j) = 0;
        end
    end
end


%Inverse and show the edges
edges = db_lp_hp_img_inv(S, 1, iter); %It works!

% figure
% subplot(2,1,1);
% imagesc(S)
% colormap gray; 
% axis image
% 
% subplot(2,1,2);
% imagesc(edges)
% colormap gray; 
% axis image

end

