function [D] = PoliCoef(x, y, z) % function that performs a polynomial fit and returns the coefficients 
[xData, yData, zData] = prepareSurfaceData( x, y, z ); % Prepares the x, y, z matrices for use in the fit function
ft = fittype( 'poly11' ); % the type of fit is established, in this case polynomial of degree 1
M = fit( [xData, yData], zData, ft); 
values=coeffvalues(M); % the values of the coefficients are stored in a vector [p00 p10 p01]
D=values(1,1)+values(1,2)*x+values(1,3)*y; % polynomial fit plane





