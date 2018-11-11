function [HSI_out] = rgbtohsi(RGB_in)

%rgb2hsv()
F = RGB_in;
F=im2double(F); %must be in double

%HSI_out = zeros(size(RGB_in));

r= F(:,:,1); %separate channels 
g= F(:,:,2);
b= F(:,:,3);

I= (r+g+b)/ 3; %intensity 
v1= (-r/2) + (-g/2) + b; %v1 for calculate S and H 
v2= sqrt(3)/2 * r + (-sqrt(3)/2) * g; 

S= sqrt( v1 .* v1 + v2 .* v2); %saturation 

H= atan2(v2,v1); %hue 

HSI_out=cat(3,H,S,I); %concat! 3 is dimension of channels

end 

