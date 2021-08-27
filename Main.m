im1= input('Enter the name of the AB image with its extension: ');
im2= input('Enter the name of the BC image with its extension: ');
im3= input('Enter the name of the CA image with its extension: ');
im4= input('Enter the name of the image AB90º with its extension: ');
AB=imread(im1); BC=imread(im2); CA=imread(im3); AB90=imread(im4); 
imshow(AB)
xmin= input('Enter the X value of the upper left corner of the cut square: ');
ymin= input('Enter the Y value of the upper left corner of the cut square: ');
w= input('Enter the length of the side of the cut square: ');
verde=1;rojo=2;
onda= input('Laser used: Green or Red? ');
if onda==1
    wave=532;
else
    wave=632.8;
end
AB1=corte(AB,xmin,ymin,w,w,wave); BC1=corte(BC,xmin,ymin,w,w,wave); CA1=corte(CA,xmin,ymin,w,w,wave); AB901=corte(AB90,xmin,ymin,w,w,wave); 
xv=0:1:w-1; yv=0:1:w-1;[x,y]=meshgrid(xv,yv); % We create a mesh on which to evaluate the height of AB1, BC1
D1=PoliCoef(x,y,AB1); D2=PoliCoef(x,y,BC1); D3=PoliCoef(x,y,CA1); D4=PoliCoef(x,y,AB901); 
a1=AB1-D1; a2=BC1-D2; a3=CA1-D3; a4=AB901-D4; 
P = input('Parts to divide the image: ');
partes = input('Parts to divide each radius: ');
D=P/2; % Number of diameters into which we divide the image
angulo1 = 360/P; % angle between consecutive radius on degrees
angulo = deg2rad(angulo1); % degree to rad 
tamano=size(AB1);
xf=tamano(2); % largest x value of the matrix ABa
yf=tamano(1); % largest y value of the matrix ABa
solucion=zeros(yf,xf); % final solution matrix
if rem(xf,2)==0 %the rem function divides the first value by the second in this case xf / 2 and returns zero if it is integer division and 1 if not
    ceros1=zeros(yf,1); % creates a column vector of zeros of elements the height of the matrix ABa
    ceros2=zeros(1,xf+1);
    AB1=[AB1,ceros1];
    AB1=[AB1;ceros2]; % the size of the matrix is increased to have an exact center
    centro=(size(AB1)+1)/2;
    xc=centro(2); % centrox
    yc=centro(1); % centroy
    tamano=size(AB1);
    xf=tamano(2); yf=tamano(1); solucion=zeros(yf,xf);
    BC1=[BC1,ceros1];
    BC1=[BC1;ceros2]; % the size of the matrix is increased to have an exact center
    CA1=[CA1,ceros1];
    CA1=[CA1;ceros2]; % the size of the matrix is increased to have an exact center
    AB901=[AB901,ceros1];
    AB901=[AB901;ceros2]; % the size of the matrix is increased to have an exact center
else
    centro=(size(AB1)+1)/2;
    xc=centro(2); % centrox
    yc=centro(1); % centroy
end
radio = xf-xc; 
M1=MatrizM(P/2); % calling M function
M2= mat_inv2(M1'*M1)*M1'; %inv(M1'*M1)*M1';
A1=MatrizL(a1,P,partes); A2=MatrizL(a2,P,partes); A3=MatrizL(a3,P,partes);A4=MatrizL(a4,P,partes);
U=zeros(4*P,1); % column vector of 4 * P elements; 4 images and the divisions P chosen
j1=1;k1=P; % placers of elements in arrays
% We obtain the L column vectors by introducing the columns of the
% vectors A in order
n=D; j=0; i1=0; cont4=D; cont5=P; valor=0;
A=1;B=2;C=3;
imagen = input('Image to obtain A, B o C? '); 
for i=1:1:partes    
    U(j1:k1,1)=A1(:,i);j1=j1+P;k1=k1+P;
    U(j1:k1,1)=A2(:,i);j1=j1+P;k1=k1+P;
    U(j1:k1,1)=A3(:,i);j1=j1+P;k1=k1+P;
    U(j1:k1,1)=A4(:,i);
    L=U;%v1=genvarname('L'); eval([v1, '=U']); 
    X=M2*L;%v2=genvarname('X'); eval([v2, '=M2*L']);
    i1=(radio/partes)+i1;
    N=i1;
    if imagen==1
        vectorX1=X(1:P,1); % selects the first N values of vectorX
    elseif imagen==2
        vectorX1=X((P+1):(2*P),1); % selects the second N values of vectorX
    elseif imagen==3
        vectorX1=X((2*P+1):(3*P),1); % selects the third N values of vectorX
    end
     while j<=(P-1)&& D-n<=D % phase increment and data storage from point 0 to the highest positive
        N1=N*cos(angulo*j); % Increment of x in the number of pixels
        N2=N*sin(angulo*j); % Increment of y in the number of pixelss
        % We round the pixel location to the nearest integer
        xp=round(xc+N1); yp=round(yc+N2);
        posicion=P-cont4;
        valor=vectorX1(posicion,1);
        %%%%%%
        solucion(xp,yp)=valor;        
        cont4=cont4-1;
        j=j+1;
        n=n-1;        
     end
     posicion=0; 
      while j<=(P-1)&& D-n<2*D % phase increment and storage of negative index data
        N1=N*cos(angulo*j); N2=N*sin(angulo*j);
        xp=round(xc+N1); yp=round(yc+N2);
        cont5=cont5-1;
        posicion=P-cont5;
        valor=vectorX1(posicion,1);
        solucion(xp,yp)=valor;               
        j=j+1;
        n=n-1;
      end    
     n=D; j=0; cont4=D; cont5=P; valor=0;    
    j1=1;k1=P; U=zeros(4*P,1); % column vector of 4 * P elements; 4 images and the divisions P chosen
end
 mesh(solucion)
