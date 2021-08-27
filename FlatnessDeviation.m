im1= input('Introduce el nombre de la imagen AB con su extensión: ');
im2= input('Introduce el nombre de la imagen BC con su extensión: ');
im3= input('Introduce el nombre de la imagen CA con su extensión: ');
im4= input('Introduce el nombre de la imagen AB90º con su extensión: ');
AB=imread(im1); BC=imread(im2); CA=imread(im3); AB90=imread(im4); 
imshow(AB)
xmin= input('Introduce el valor X del extremo superior izquierdo del cuadrado de corte: ');
ymin= input('Introduce el valor Y del extremo superior izquierdo del cuadrado de corte: ');
w= input('Introduce el largo del lado del cuadrado de corte: ');
verde=1;rojo=2;
onda= input('¿Láser verde o rojo? ');
if onda==1
    wave=532;
else
    wave=632.8;
end
AB1=corte(AB,xmin,ymin,w,w,wave); BC1=corte(BC,xmin,ymin,w,w,wave); CA1=corte(CA,xmin,ymin,w,w,wave); AB901=corte(AB90,xmin,ymin,w,w,wave); 
xv=0:1:w-1; yv=0:1:w-1;[x,y]=meshgrid(xv,yv); %creamos una malla en la que evaluar la altura de AB1, BC1
D1=PoliCoef(x,y,AB1); D2=PoliCoef(x,y,BC1); D3=PoliCoef(x,y,CA1); D4=PoliCoef(x,y,AB901); 
a1=AB1-D1; a2=BC1-D2; a3=CA1-D3; a4=AB901-D4; % Planos de las restas 
P = input('Partes a dividir la imagen : ');
partes = input('Partes a dividir cada radio : ');
D=P/2; % número de diámetros en los que dividimos la imagen
angulo1 = 360/P; % ángulo entre radios consecutivos en grados
angulo = deg2rad(angulo1); % pasamos el ángulo a radianes 
tamano=size(AB1);
xf=tamano(2); % valor x más grande de la matriz ABa
yf=tamano(1); % valor y más grande de la matriz ABa
solucion=zeros(yf,xf); % matriz en la que se almacenaran los valores ordenados
if rem(xf,2)==0 % la función rem divide el primer valor entre el segundo en este caso xf/2 y devuelve cero si es división entera y 1 si no
    ceros1=zeros(yf,1); % crea un vector columna de ceros de elementos la altura de la matriz ABa
    ceros2=zeros(1,xf+1);
    AB1=[AB1,ceros1];
    AB1=[AB1;ceros2]; % se aumenta el tamaño de la matriz para que tenga un centro exacto
    centro=(size(AB1)+1)/2;
    xc=centro(2); % centrox
    yc=centro(1); % centroy
    tamano=size(AB1);
    xf=tamano(2); yf=tamano(1); solucion=zeros(yf,xf);
    BC1=[BC1,ceros1];
    BC1=[BC1;ceros2]; % se aumenta el tamaño de la matriz BC1 para que tenga un centro exacto
    CA1=[CA1,ceros1];
    CA1=[CA1;ceros2]; % se aumenta el tamaño de la matriz CA1 para que tenga un centro exacto
    AB901=[AB901,ceros1];
    AB901=[AB901;ceros2]; % se aumenta el tamaño de la matriz AB901 para que tenga un centro exacto
else
    centro=(size(AB1)+1)/2;
    xc=centro(2); % centrox
    yc=centro(1); % centroy
end
radio = xf-xc; 
M1=MatrizM(P/2); %se genera la matriz M correspondiente
M2= mat_inv2(M1'*M1)*M1'; %inv(M1'*M1)*M1';
A1=MatrizL(a1,P,partes); A2=MatrizL(a2,P,partes); A3=MatrizL(a3,P,partes);A4=MatrizL(a4,P,partes);
U=zeros(4*P,1); % vector columna de 4*P elementos; 4 imágenes y las divisiones P elegidas
j1=1;k1=P; % colocadores de los elementos en las matrices
%Obtenemos los vectores L columna introduciendo las columnas de los
%vectores A en orden
n=D; j=0; i1=0; cont4=D; cont5=P; valor=0;
A=1;B=2;C=3;
imagen = input('¿Que imagen deseas obtener A, B o C? '); 
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
        vectorX1=X(1:P,1); % selecciona los N primeros valores de vectorX
    elseif imagen==2
        vectorX1=X((P+1):(2*P),1); % selecciona los segundos N valores de vectorX
    elseif imagen==3
        vectorX1=X((2*P+1):(3*P),1); % selecciona los segundos N valores de vectorX
    end
     while j<=(P-1)&& D-n<=D % incremento de la fase y almacenamiento de los datos desde el punto 0 al mayor positivo
        N1=N*cos(angulo*j); % Incremento de x en el número de píxeles
        N2=N*sin(angulo*j); % Incremento de y en el número de píxeles
        % Redondeamos la ubicación del píxel al entero más cercano
        xp=round(xc+N1); yp=round(yc+N2);
        %seleccionamos los valores del vector vectorX1 que nos interesan en
        %este caso
        posicion=P-cont4;
        valor=vectorX1(posicion,1);
        %%%%%%
        solucion(xp,yp)=valor; % ubicamos el valor en la posición de la matriz solución        
        cont4=cont4-1;
        j=j+1;
        n=n-1;        
     end
     posicion=0; 
      while j<=(P-1)&& D-n<2*D % incremento de la fase y almacenamiento de los datos de índice negativo 
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
    j1=1;k1=P; U=zeros(4*P,1); % vector columna de 4*P elementos; 4 imágenes y las divisiones P elegidas
end
 mesh(solucion)