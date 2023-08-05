function [ V ] = vmatrix(l,m,q1,q2,q3,q1p,q2p,q3p)

dtk1=(l^2*m*(q1p*(sin(2*q3)*(q3p*cos(q1-q2)*(5+4*cos(q1-q2))^2+2*(q1p-q2p)*(5*(sin(q1-q2)+sin(2*(q1-q2)))+sin(3*(q1-q2)))*sin(2*q3))-q3p*cos(q1-q2)*(5+4*cos(q1-q2))^2*sin(4*q3))+q3p*(5+4*cos(q1-q2))*(2*q3p*(cos(2*q3)-2*cos(4*q3))*(5*sin(q1-q2)+2*sin(2*(q1-q2)))-5*q1p*(5+4*cos(q1-q2))*sin(2*q3)+4*(q1p-q2p)*sin(q1-q2)^2*sin(4*q3))+q2p*((q1p-q2p)*(-1+cos(4*q3))*(5*(sin(q1-q2)+sin(2*(q1-q2)))+sin(3*(q1-q2)))+q3p*cos(q1-q2)*(5+4*cos(q1-q2))^2*(-sin(2*q3)+sin(4*q3)))))/(4*(5+4*cos(q1-q2)^2));
dtk2=(l^2*m*(-2*q3p*(cos(2*q3)-2*cos(4*q3))*(5*sin(q1-q2)+2*sin(2*(q1-q2)))-5*q2p*(5+4*cos(q1-q2))*sin(2*q3)+4*(-q1p+q2p)*sin(q1-q2)^2*sin(4*q3)))/4*(5+4*cos(q1-q2));
dtk3=(1/2)*l^2*m*((q1p-q2p)*(cos(2*q3)-2*cos(4*q3))*sin(q1-q2)+q3p*(5+4*cos(q1-q2))*(sin(2*q3)-2*sin(4*q3)));
u1=(l^2*m*(-8*q3p^2*(5+4*cos(q1-q2))^2*cos(2*q3)^2*sin(q1-q2)+(6*((q1p-q2p)^2-22*q3p^2)+2*((q1p-q2p)^2-16*q3p^2)*(5*cos(q1-q2)+cos(2*(q1-q2)))+4*q3p^2*(5+4*cos(q1-q2))^2*cos(2*q3)-5*(q1p-q2p)^2*cos(4*q3))*sin(q1-q2)+(q1p-q2p)*(-(q1p-q2p)*cos(4*q3)*(5*sin(2*(q1-q2))+sin(3*(q1-q2)))+2*q3p*cos(q1-q2)*(5+4*cos(q1-q2))^2*(sin(2*q3)-sin(4*q3)))))/(8*(5+4*cos(q1-q2))^2);
u2=(l^2*m*(8*q3p^2*(5+4*cos(q1-q2))^2*cos(2*q3)^2*sin(q1-q2)+(-6*((q1p-q2p)^2+132*q3p^2)-2*((q1p-q2p)^2-16*q3p^2)*(5*cos(q1-q2)+cos(2*(q1-q2)))-4*q3p^2*(5+4*cos(q1-q2))^2*cos(2*q3)+5*(q1p-q2p)^2*cos(4*q3))*sin(q1-q2)+(q1p-q2p)*((q1p-q2p)*cos(4*q3)*(5*sin(2*(q1-q2))+sin(3*(q1-q2)))+2*q3p*cos(q1-q2)*(5+4*cos(q1-q2))^2*(-sin(2*q3)+sin(4*q3)))))/(8*(5+4*cos(q1-q2))^2);
u3=(l^2*m*(4*(q1p-q2p)*q3p*cos(2*q3)*(5*sin(q1-q2)+2*sin(2*(q1-q2)))-8*(q1p-q2p)*q3p*cos(4*q3)*(5*sin(q1-q2)+2*sin(2*(q1-q2)))+(5+4*cos(q1-q2))*(-5*(q1p^2+q2p^2-2*q3p^2)+8*q3p^2*cos(q1-q2))*sin(2*q3)-2*(-(q1p-q2p)^2+66*q3p^2+80*q3p^2*cos(q1-q2)+((q1p-q2p)^2+16*q3p^2)*cos(2*(q1-q2)))*sin(4*q3)))/(8*(5+4*cos(q1-q2)));

v1 = dtk1-u1;
v2 = dtk2-u2;
v3 = dtk3-u3;

V = [v1; v2; v3];

end

