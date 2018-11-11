function shrinked = waveletShrinkage_hard(x, N ,iter)
%x is the signal 
%N is the type of DB wavelet
%iter is the number of iterations

% c = [1/sqrt(2), 1/sqrt(2)]; %Haar used changed to DB
% d = [1/sqrt(2), -1/sqrt(2)]; 

%DB transform 
x_deb = db_lp_hp(x, N, iter); 

[len, n] = size(x_deb); %check!! if x_deb is vertical, m will be length

%b will be the first b term (last and longest in the x_deb - C 

b = x_deb(len/2 + 1: len); %always be the half of the length 

% [row1, len] = size(x);
% [a, b] = dwlt(x,c,d); 
% init = a; 
% C = [b];
% 
% for i=1:(iter - 1)
%     [a1, b1] = dwlt(init,c,d);
%     init = a1; 
%     C = [b1 C]; 
% end 
% 
% C = [a1 C];

sigma = mad(b,1)/0.6745; %median absolute deviation, use the finest b is the beginning one
lambda = sigma*sqrt(2*log(len)); 

%hard threshold 
for i=1:len 
    if abs(x_deb(i)) <= lambda 
        x_deb(i) = 0; 
    end
end

%inverse of x_deb 
shrinked = inv_db_lp_hp(x_deb, N, iter);

end
    





