function [L]=MatrizL(ABa,P,partes) % This function will provide us with the L matrix of a plane
% each column of the matrix corresponds to a series of values that will be
%concatenated into rows with the values of the corresponding columns of
% the other planes. "AB" is the work plane, "P" the parts to be divided each
% image and "parts" the parts into which we divide each diameter.
% THIS FUNCTION IS ONLY USED FOR SQUARE DIES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
D = P/2; % Nº of diameters used
angulo1 = 360/P; % angles between consecutive radius
angulo = deg2rad(angulo1); % degrees to rad

tamano=size(ABa);
xf=tamano(2); % largest x value from matrix ABa
yf=tamano(1); % largest y value from matrix ABa
if rem(xf,2)==0 % the rem function divides the first value by the second in this case xf / 2 and returns zero if it is integer division and 1 if not
    ceros1=zeros(yf,1); % creates a column vector of zeros of elements the height of the matrix ABa
    ceros2=zeros(1,xf+1);
    ABa=[ABa,ceros1];
    ABa=[ABa;ceros2]; 
    centro=(size(ABa)+1)/2;
    xc=centro(2); % x center
    yc=centro(1); % y center
    tamano=size(ABa);xf=tamano(2);
else
    centro=(size(ABa)+1)/2;
    xc=centro(2); % x center
    yc=centro(1); % y center
end
radio = xf-xc; % radius of the circumference image in pixels
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Of the following vectors the first contains the first half of points
% +1 from 0; the second contains negative values ​​the sum Lk2 + Lk1 is
% Lij
Lk2=zeros(1+P/2,1); Lk1=zeros((P/2)-1,1); L=zeros(P,partes);
n=D; j=0; w1=0; i=0; w2=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Increase in the radius of the concentric circles taken
while i+xc<radio+xc || i+yc<radio+xc     
    for k=1:1:partes 
    i=(radio/partes)+i;
    N=i;    
    while j<=(P-1)&& D-n<=D % phase increment and data storage from point 0 to the highest positive
     w1=w1+1;  
     N1=N*cos(angulo*j); % Increment of x in the number of pixels
     N2=N*sin(angulo*j); % Increment of y in the number of pixels
      % We round the pixel location to the nearest integer
     xp=round(xc+N1);
     yp=round(yc+N2);
     % accesses the xp, yp location of the deviation matrix and stores
     % the value in array Lk1
     aij=ABa(xp,yp);    
     Lk2(w1,1)=aij;
     j=j+1;
     n=n-1;
    end     
     while j<=(P-1)&& D-n<2*D % phase increment and storage of negative index data
     w2=w2+1;  
     N1=N*cos(angulo*j); N2=N*sin(angulo*j);
     xp=round(xc+N1); yp=round(yc+N2);
     aij=ABa(xp,yp);     
     Lk1(w2,1)=aij;
     j=j+1;
     n=n-1;
     end        
    Lij=[Lk1;Lk2]; % the data are stored in the vector L of the system to be solved    
    for h=1:1:P
        L(h,k)=Lij(h);
    end
    j=0;w1=0;w2=0;n=D;
    end    
end
