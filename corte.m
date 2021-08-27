function [d]=corte(AB, xmin, ymin, w, h, wave)%vamos a cortar un rectángulo de la imagen para hacer el ajuste
%por mínimos cuadrado
AB = im2double(AB);
r=[xmin ymin w h];
I=imcrop(AB,r);
%D = 2*pi*I/255 ; % la matriz D tiene en cada celda los valores de ?
d = wave*I*5/0.8 ; % obtiene las distancias de separación entre espejos en nm, si la longitud de onda está en nm.
