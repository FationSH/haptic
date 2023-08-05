function [  ] = det0( l )

for q1=10:1:160
    for q2=(q1+10):1:170 % q2 >= q1+10 panta
        for q3=0:1:70
            J = Jacobian(l,q1,q2,q3);
            detJ = det(J);
            if detJ == 0
                disp('Determinant == 0 :');
                disp(q1);
                disp(q2);
                disp(q3);
            end
        end
        for q3=290:1:360
            J = Jacobian(l,q1,q2,q3);
            detJ = det(J);
            if detJ == 0
                disp('Determinant == 0 :');
                disp(q1);
                disp(q2);
                disp(q3);
            end
        end
    end
end

end
