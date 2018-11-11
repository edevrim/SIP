function shrinked = waveletShrinkage(x, N ,iter)
%x is the signal 
%N is the type of DB wavelet
%iter is the number of iterations

%DB transform 
x_deb = db_lp_hp(x, N, iter); 

[len, n] = size(x_deb); %check!! if x_deb is vertical, m will be length

%b will be the first b term (last and longest in the x_deb - C 

b = x_deb(len/2 + 1: len); 

sigma = mad(b,1)/0.6745; %median absolute deviation, uses the finest b
lambda = sigma*sqrt(2*log(len)); 

%soft threshold 
for i=1:len 
    if abs(x_deb(i)) <= lambda 
        x_deb(i) = 0; 
    elseif x_deb(i) > lambda
            x_deb(i) = x_deb(i) - lambda;
        else 
            x_deb(i) = x_deb(i) + lambda;
    end
end

%inverse of x_deb 
shrinked = inv_db_lp_hp(x_deb, N, iter);

end
