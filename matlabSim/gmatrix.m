function [ G ] = gmatrix(l,m,q3)

q3 = q3*(pi/180);
g = 9.7;

G = [0; 0; 4*g*l*m*cos(q3)];


end

