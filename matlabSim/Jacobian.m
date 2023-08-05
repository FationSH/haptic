function [ J ] = Jacobian(l,q1,q2,q3)

[q1, q2,q3] = toRad(q1, q2, q3);

J=[-(sqrt(2)*l^2*cos((q1-q2)/2)*cos(q3)*sin(q1))/sqrt(l^2*(1+cos(q1-q2))) ...
    -(sqrt(2)*l^2*cos((q1-q2)/2)*cos(q3)*sin(q2))/sqrt(l^2*(1+cos(q1-q2))) ...
    -sqrt(2)*sqrt(l^2*(1+cos(q1-q2)))*cos((q1+q2)/2)*sin(q3);
    (sqrt(2)*l^2*cos(q1)*cos((q1-q2)/2)*cos(q3))/sqrt(l^2*(1+cos(q1-q2))) ...
    (sqrt(2)*l^2*cos((q1-q2)/2)*cos(q2)*cos(q3))/sqrt(l^2*(1+cos(q1-q2))) ...
    -sqrt(2)*sqrt(l^2*(1+cos(q1-q2)))*sin((q1+q2)/2)*sin(q3);
    -(l^2*sin(q1-q2)*sin(q3))/2*sqrt(l^2*cos((q1-q2)/2)^2) ...
    (l^2*sin(q1-q2)*sin(q3))/2*sqrt(l^2*cos((q1-q2)/2)^2) ...
    sqrt(2)*sqrt(l^2*(1+cos(q1-q2)))*cos(q3)];

%     [-(sqrt(2)*l^2*cos((q1-q2)/2)*cos(q3)*sin(q1))/sqrt(l^2*(1+cos(q1-q2))) ...
%     -(sqrt(2)*l^2*cos((q1-q2)/2)*cos(q3)*sin(q2))/sqrt(l^2*(1+cos(q1-q2))) ...
%     -sqrt(2)*sqrt(l^2*(1+cos(q1-q2)))*cos((q1+q2)/2)*sin(q3);
%     (sqrt(2)*l^2*cos(q1)*cos((q1-q2)/2)*cos(q3))/sqrt(l^2*(1+cos(q1-q2))) ...
%     (sqrt(2)*l^2*cos((q1-q2)/2)*cos(q2)*cos(q3))/sqrt(l^2*(1+cos(q1-q2))) ...
%     -sqrt(2)*sqrt(l^2*(1+cos(q1-q2)))*sin((q1+q2)/2)*sin(q3);
%     -(l^2*sin(q1-q2)*sin(q3))/2*sqrt(l^2*cos((q1-q2)/2)^2) ...
%     (l^2*sin(q1-q2)*sin(q3))/2*sqrt(l^2*cos((q1-q2)/2)^2) ...
%     sqrt(2)*sqrt(l^2*(1+cos(q1-q2)))*cos(q3)];
end

