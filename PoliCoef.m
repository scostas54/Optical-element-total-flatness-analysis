function [D] = PoliCoef(x, y, z) % función que realiza un ajuste polinomial y devuelve los coeficientes 
[xData, yData, zData] = prepareSurfaceData( x, y, z ); % prepara las matrices x,y,z para su uso en la función fit
ft = fittype( 'poly11' ); % se establece el tipo de ajuste, en este caso polinomial de grado 1
M = fit( [xData, yData], zData, ft); % se realiza el ajuste
values=coeffvalues(M); % se almacenan los valores de los coeficientes en un vector [p00 p10 p01]
D=values(1,1)+values(1,2)*x+values(1,3)*y; % plano de ajuste polinomial





