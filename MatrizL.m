function [L]=MatrizL(ABa,P,partes) % Esta función nos proporcionara la matriz L de un plano
% cada columna de la matriz corresponde a una serie de valores que se
% concatenarán en filas con los valores de las columnas correspondientes de
% los otros planos. "AB" es el plano de trabajo, "P" las partes a dividir cada
% imagen y "partes" las partes en las que dividimos cada diámetro.
% ESTA FUNCIÓN SOLO SIRVE PARA MATRICES CUADRADAS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
D = P/2; % Diámetros que vamos a utilizar en la imagen
angulo1 = 360/P; % ángulo entre radios consecutivos en grados
angulo = deg2rad(angulo1); % pasamos el ángulo a radianes
%cálculo del punto medio de la imagen
tamano=size(ABa);
xf=tamano(2); % valor x más grande de la matriz ABa
yf=tamano(1); % valor y más grande de la matriz ABa
if rem(xf,2)==0 % la función rem divide el primer valor entre el segundo en este caso xf/2 y devuelve cero si es división entera y 1 si no
    ceros1=zeros(yf,1); % crea un vector columna de ceros de elementos la altura de la matriz ABa
    ceros2=zeros(1,xf+1);
    ABa=[ABa,ceros1];
    ABa=[ABa;ceros2]; % se aumenta el tamaño de la matriz para que tenga un centro exacto
    centro=(size(ABa)+1)/2;
    xc=centro(2); % centrox
    yc=centro(1); % centroy
    tamano=size(ABa);xf=tamano(2);
else
    centro=(size(ABa)+1)/2;
    xc=centro(2); % centrox
    yc=centro(1); % centroy
end
radio = xf-xc; % radio de la circunferencia imagen en píxeles
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% De los vectores siguientes el primero contiene la primera mitad de puntos
% +1 desde 0; el segundo contiene los valores negativos la de suma Lk2+Lk1 es
% Lij
Lk2=zeros(1+P/2,1); Lk1=zeros((P/2)-1,1); L=zeros(P,partes);
n=D; j=0; w1=0; i=0; w2=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Incremento del radio de las circunferencias concéntricas que cogemos
while i+xc<radio+xc || i+yc<radio+xc     
    for k=1:1:partes 
    i=(radio/partes)+i;
    N=i;    
    while j<=(P-1)&& D-n<=D % incremento de la fase y almacenamiento de los datos desde el punto 0 al mayor positivo
     w1=w1+1;  
     N1=N*cos(angulo*j); % Incremento de x en el número de píxeles
     N2=N*sin(angulo*j); % Incremento de y en el número de píxeles
      % Redondeamos la ubicación del píxel al entero más cercano
     xp=round(xc+N1);
     yp=round(yc+N2);
     % accede a la ubicación xp, yp de la matriz de desviaciones y almacena
     % el valor en la matriz Lk1
     aij=ABa(xp,yp);    
     Lk2(w1,1)=aij;
     j=j+1;
     n=n-1;
    end     
     while j<=(P-1)&& D-n<2*D % incremento de la fase y almacenamiento de los datos de índice negativo 
     w2=w2+1;  
     N1=N*cos(angulo*j); N2=N*sin(angulo*j);
     xp=round(xc+N1); yp=round(yc+N2);
     aij=ABa(xp,yp);     
     Lk1(w2,1)=aij;
     j=j+1;
     n=n-1;
     end        
    Lij=[Lk1;Lk2]; % se almacenan los datos en el vector L del sistema a resolver    
    for h=1:1:P
        L(h,k)=Lij(h);
    end
    j=0;w1=0;w2=0;n=D;
    end    
end
