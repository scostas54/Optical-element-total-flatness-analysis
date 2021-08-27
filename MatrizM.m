function [M]=MatrizM(D) % Enter the number of diameters in which you want to
% divide the image, the function returns the matrix M
identidad=eye(2*D); % we define the identity matrix of 2diam X 2diam elements
Z= zeros(2*D);    % 2N x 2N matrix composed of zeros
identidad1=eye(2*D); identidad2=eye(2*D); 
% Obtaining the first matrix similar to the identity but with the rows changed position
cont2=0;
for cont1=(2*D-1):(-1):1       
        cont2=cont2+1;    
        identidad1(cont2,:)=identidad(cont1,:);   
end
cont2=1; % we reset the value of the counters
% Obtaining the second matrix similar to the identity but with the rows
% changed
for cont1=(2*D):(-1):2
        cont2=cont2+1;
        identidad2(cont2,:)=identidad(cont1,:);    
end
M=[identidad identidad1 Z;Z identidad identidad1;identidad1 Z identidad;identidad identidad2 Z];

