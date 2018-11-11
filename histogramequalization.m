function [D] = histogramequalization(C)

 max_r = size(C, 1); %row number
 max_c = size(C, 2); %col number
 var1 = 0; %used in sum of cumulative hist values 

 hist = zeros([1 256]); %initialize all zeros, it will keep pixel values
 cum_hist = zeros([1 256]); %it will keep cumulative hist values 
 new_pxls = zeros([1 256]);
 D = zeros(size(C)); %initialize output matrix
 
 for r = 1:max_r %scan all rows
     for c= 1:max_c %all columns 
         for count= 1:256 %search for all possible pixel b to w 
             if C(r,c) == count - 1 %  if count - 1 i am looking for black, and if these pixel = black then count 1  
                 hist(count) = hist(count) + 1;
                 break; 
             end
         end
     end
 end
 
 
for count= 1:256 
    var1 = var1 + hist(count); 
    cum_hist(count) = var1; 
end

for count= 1:256 
    new_pxls(count) = floor(256 * (cum_hist(count) / cum_hist(end))); %new pixel values! 
end
    

 for r = 1:max_r %scan all rows
     for c= 1:max_c %all columns 
         for count= 1:256 %search for all possible pixel b to w 
             if C(r,c) == count - 1 
                 D(r, c) = new_pxls(count); %assign values 
                 break; 
             end
         end
     end
 end
 
 D = uint8(D); 
 
end
 
 
 