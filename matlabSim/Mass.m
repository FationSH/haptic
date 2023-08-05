function [ M ] = Mass(l,q1,q2,q3,m,Ixx1,Ixx2,Ixx3,Ixx4,Izz1,Izz2,Izz3,Izz4)

[q1, q2,q3] = toRad(q1, q2, q3);

M1=(40*(Izz1+Izz4)+26*l^2*m+4*cos(q1-q2)*(8*(Izz1+Izz4)+5*l^2*m*cos(2*q3))+l^2*m*(-cos(2*(q1-q2))+25*cos(2*q3)-2*cos(4*q3)*sin(q1-q2)^2))/(8*(5+4*cos(q1-q2)));
M2=(-l^2*m+l^2*m*(cos(2*(q1-q2))+2*cos(4*q3)))/(8*(5+4*cos(q1-q2)));
M3=l^2*m*(2*(5*sin(q1-q2)+2*sin(2*(q1-q2)))*sin(2*q3)-2*(5*sin(q1-q2)+2*sin(2*(q1-q2)))*sin(4*q3))/(8*(5+4*cos(q1-q2)));
M4=l^2*m*(-2*sin(q1-q2)^2*sin(2*q3))/(4*(5+4*cos(q1-q2)));
M5=(20*(Izz2+Izz3)+2*cos(q1-q2)*((8*(Izz2+Izz3)+5*l^2*m)+l^2*m*5*cos(2*q3))+l^2*m*(25*cos(q2)^2*cos(q3)^2+25*cos(q3)^2*sin(q2)^2+sin(2*q3)*2*sin(q1-q2)^2*sin(2*q3)))/(4*(5+4*cos(q1-q2)));
M6=(-2*cos(q1-q2)*l^2*m*cos(q1-q2-2*q3)+l^2*m*(cos(2*q3)+cos(q1-q2+q3)-5*cos(q2)*sin(q1)*sin(2*q3)+sin(2*q3)*5*cos(q1)*sin(q2)+5*sin(q1-q2)+2*sin(2*(q1-q2)))*sin(4*q3))/(4*(5+4*cos(q1-q2)));
M7=(1/4)*l^2*m*(sin(q1-q2)*(sin(2*q3)-sin(4*q3)));
M8=(1/4)*l^2*m*(-sin(q1-q2)*(sin(2*q3)-sin(4*q3)));
M9=(1/4)*(4*(Ixx1+Ixx2+Ixx3+Ixx4)+l^2*m*(12-5*cos(2*q3)+5*cos(4*q3)+4*cos(q1-q2)*(2-cos(2*q3)+cos(4*q3))));

M=[M1 M2 M3; M4 M5 M6; M7 M8 M9];

end

