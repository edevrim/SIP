function edges = haar_edge_det_easy(image, iter)
%Image 
%iter is the number of iterations of haar 

haared = db_lp_hp_img(double(image), 1, iter); %1 is for haar 
%it just converts Blur part to zero then takes the inverse 

[m, n] = size(haared); 
%convert first block (B) to zero (black)

haared_2 = haared; 

for i=1:m/2^iter
    for j=1:n/2^iter
        haared_2(i,j) = 0;
    end 
end

edges = db_lp_hp_img_inv(haared_2, 1, iter);

end

