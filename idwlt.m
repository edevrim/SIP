function [x] = idwlt(xa, xb, c, d)

a = zeros(1, length(xa)*2 + 1); 
for n=1:length(a)/2
    a(n*2) = xa(n);  
end

b = zeros(1, length(xb)*2 + 1); 
for n=1:length(b)/2
    b(n*2) = xb(n);     
end     

a = a(2:length(a)); 
b = b(2:length(b)); 

x1 = filter(c, 1, a);
x2 = filter(d, 1, b);

x = x1 + x2; 
end
