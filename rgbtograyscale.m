function [rgbimage_out] = rgbtograyscale(rgbimage_in)

 rgbimage_out(:,:, 1) = 0.2989 * rgbimage_in(:,:, 1) + 0.5870 * rgbimage_in(:,:, 2) + 0.1140 * rgbimage_in(:,:, 3); %all reds are gray
 rgbimage_out(:,:, 2) = 0.2989 * rgbimage_in(:,:, 1) + 0.5870 * rgbimage_in(:,:, 2) + 0.1140 * rgbimage_in(:,:, 3); %all greens are gray
 rgbimage_out(:,:, 3) = 0.2989 * rgbimage_in(:,:, 1) + 0.5870 * rgbimage_in(:,:, 2) + 0.1140 * rgbimage_in(:,:, 3); %so for all blues
 
 ;
end

