function [A, Z, U, S, V] = pca_svd(X)

%Perform PCA on data by Singular Value Decomposition
%X is the original signals. (horizontal) 

[m,n] = size(X);
mx = mean(X,2); 
Xo = X - mx*ones(1, n); %Mean substraction needed to centeralize data
%If we work on uncentralized data we would work on energy instead of
%variance

figure
subplot(2,2,1);
plot(X'); %plot vertically
title('original data');
subplot(2,2,2);
plot(Xo'); 
grid on 
title('centered data'); 

%svd
[U, S, V] = svd(Xo,'econ'); %produces an economy-size decomposition of m-by-n matrix A

N = n; %the number of samples
A = U * S / sqrt(N-1); %diagonal transfer matrix 
%First column of A shows direction of first PCA!
Z = sqrt(N-1) * V'; %Principle components

subplot(2,2,3);
stem(diag(S)); %shows the dist of every element 
grid on 
title('distances of elements'); 

end

