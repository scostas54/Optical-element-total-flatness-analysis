function [M]=MatrizM(D) % Se introduce el número de diámetros en los que se quiere
%dividir la imagen y la función devuelve la matriz M
identidad=eye(2*D); % definimos la matriz identidad de 2diam X 2diam elementos 
Z= zeros(2*D);    % matriz de 2N x 2N elementos compuesta por ceros
identidad1=eye(2*D); identidad2=eye(2*D); 
% Obtención de la primera matriz similar a la identidad pero con las filas
% cambiadas de posición
cont2=0;
for cont1=(2*D-1):(-1):1       
        cont2=cont2+1;    
        identidad1(cont2,:)=identidad(cont1,:);   
end
cont2=1; % reiniciamos el valor de los contadores
% Obtención de la segunda matriz similar a la identidad pero con las filas
% cambiadas
for cont1=(2*D):(-1):2
        cont2=cont2+1;
        identidad2(cont2,:)=identidad(cont1,:);    
end
M=[identidad identidad1 Z;Z identidad identidad1;identidad1 Z identidad;identidad identidad2 Z];

