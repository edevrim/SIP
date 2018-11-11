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

%HSI_out(:,:,1) = I; %hue channel
%HSI_out(:,:,2) = H; 
%HSI_out(:,:,3) = S; 

%th=acos((0.5*((r-g)+(r-b)))./((sqrt((r-g).^2+(r-b).*(g-b)))+eps));
%H=th;
%H(b>g)=2*pi-H(b>g);
%H=H/(2*pi);
%S=1-3.*(min(min(r,g),b))./(r+g+b+eps);
%hsi=cat(3,H,S,I);

end 

