function [ I ] = tensors(q1, q2, q3, lm)

    m = 0.05; % mass == 50gr
    w = 0.001; h = 0.001; % polu mikra se sxesh me to l
    l = 0.1; % l == 10cm
    
    % Tanusths ws pros kentro mazas
    Icm = [(m/12)*(w^2+h^2) 0 0;0 (m/12)*(w^2+h^2) 0; 0 0 (m/12)*(w^2+h^2)];
    
    % R tabels (R1 == R4 && R2 == R3)
    if lm == 1 || lm == 4
        Rx = rotateMat('x', q1);
    else
        Rx = rotateMat('x', q1);
    end
    Rz = rotateMat('z', q3);
    
    % Rotate
    Isf = (Rx*Rz)*Icm*(Rx*Rz)';
    
    % Centre of mass
    if lm == 1
        x = (l/2)*cos(q1)*cos(q3);
        y = (l/2)*sin(q1)*cos(q3);
        z = (l/2)*sin(q3);
    elseif lm == 2
        x = (l/2)*cos(q2)*cos(q3);
        y = (l/2)*sin(q2)*cos(q3);
        z = (l/2)*sin(q3);
    elseif lm == 3
        x = l*cos(q1)*cos(q3)+(l/2)*cos(q2)*cos(q3);
        y = l*sin(q1)*cos(q3)+(l/2)*sin(q2)*cos(q3);
        z = sqrt(x^2+y^2)*sin(q3);
    else
        x = l*cos(q2)*cos(q3)+(l/2)*cos(q1)*cos(q3);
        y = l*sin(q2)*cos(q3)+(l/2)*sin(q1)*cos(q3);
        z = sqrt(x^2+y^2)*sin(q3);
    end
    
    Dis = [y^2+z^2 -x*y -x*z; -y*x x^2+z^2 -y*z; -z*x -z*y x^2+y^2];
    
    % Transfer
    I = Isf + m*Dis;
end
