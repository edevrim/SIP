function [I_out] = linearscale(I_in, I_min_out, I_max_out)

max_r = size(I_in, 1); %row number
max_c = size(I_in, 2); %col number
I_min_in = 256; %initialize
I_max_in = 0; %initialize
I_out = zeros(size(I_in)); %initialize 

%first find image min and max pixels 

 for r = 1:max_r %scan all rows
     for c= 1:max_c %all columns 
         if I_in(r,c) < I_min_in
             I_min_in = I_in(r,c); 
         end
     end
 end
 
  for r = 1:max_r %scan all rows
     for c= 1:max_c %all columns 
         if I_in(r,c) > I_max_in
             I_max_in = I_in(r,c); 
         end
     end
  end

 slope = (double(I_max_out - I_min_out) / double(I_max_in - I_min_in)); %slope 
 intercept = double(I_min_out) - slope * double(I_min_in); 
 
 %calculate l_out using slope and intercept 
 
 for r = 1:max_r %scan all rows
     for c= 1:max_c %all columns
         I_out(r,c) = slope * I_in(r,c) + intercept; 
         I_out(r,c) = floor(I_out(r,c)); 
     end
 end
 
 I_out = uint8(I_out); 
end
 
         
 
 

