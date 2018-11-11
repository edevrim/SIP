function [A, Z, U, D] = pca_evd(X)
%Perform PCA on data by Eigen Value Decomposition
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

N = length(Xo);
Rx = Xo * Xo'/(N-1); %correlation matrix of Xo
[U, D] = eig(Rx); %D - eigenvalues diagonal, U-eigenvectors Eigenvalue decomposition

D = fliplr(flipud(D)); %first eigenvalue must be most important 
%Check D's values
U = fliplr(U); %also flip the vectors as well

%Mean subtraction (a.k.a. "mean centering") is necessary for performing 
% classical PCA to ensure that the first principal component 
% describes the direction of maximum variance. 
% If mean subtraction is not performed, 
% the first principal component might instead correspond 
% more or less to the mean of the data

%The eigenvector with the largest eigenvalue is the direction 
% along which the data set has the maximum variance. 
%In the course we have seen that the PCA model can be described as: X = AZ.

%X = A*Z ; %Z is matrix of PCs and A transfer function
%variation 2 EVD Method

A = U*D^(1/2); %keeps direction eigenvalues
Z = D^(-1/2)*U'*Xo; %vectors PCs are in it

end

