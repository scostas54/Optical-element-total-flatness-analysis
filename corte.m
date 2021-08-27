function [d]=corte(AB, xmin, ymin, w, h, wave) % Image cut to use in Least Squares adjustment
AB = im2double(AB);
r=[xmin ymin w h];
I=imcrop(AB,r);
%D = 2*pi*I/255 ; % la matriz D tiene en cada celda los valores de ?
d = wave*I*5/0.8 ; % Obtains the distances between mirrors in nm, if the wavelength is in nm.
