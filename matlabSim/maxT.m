function [ ] = maxT( l )

F = [1; 1; 1];
maxx = 0;
maxy = 0;
maxz = 0;
max1q1 = 0;
max1q2 = 0;
max1q3 = 0;
max2q1 = 0;
max2q2 = 0;
max2q3 = 0;
max3q1 = 0;
max3q2 = 0;
max3q3 = 0;

for q1=10:1:160
    for q2=(q1+10):1:170 % q2 >= q1+10 panta
        for q3=0:1:70
            J = Jacobian(l,q1,q2,q3);
            t = Statikh(J, F);
            if abs(t(1)) > maxx
                maxx = t(1);
                max1q1 = q1;
                max1q2 = q2;
                max1q3 = q3;
            end
            if abs(t(2)) > maxy
                maxy = t(2);
                max2q1 = q1;
                max2q2 = q2;
                max2q3 = q3;
            end
            if abs(t(3)) > maxz
                maxz = t(3);
                max3q1 = q1;
                max3q2 = q2;
                max3q3 = q3;
            end
       end
       for q3=290:1:360
            J = Jacobian(l,q1,q2,q3);
            t = Statikh(J, F);
            if abs(t(1)) > maxx
                maxx = t(1);
                max1q1 = q1;
                max1q2 = q2;
                max1q3 = q3;
            end
            if abs(t(2)) > maxy
                maxy = t(2);
                max2q1 = q1;
                max2q2 = q2;
                max2q3 = q3;
            end
            if abs(t(3)) > maxz
                maxz = t(3);
                max3q1 = q1;
                max3q2 = q2;
                max3q3 = q3;
            end
       end
    end
end
disp(abs(maxx));
disp(abs(maxy));
disp(abs(maxz));
disp(max1q1);
disp(max1q2);
disp(max1q3);
disp(max2q1);
disp(max2q2);
disp(max2q3);
disp(max3q1);
disp(max3q2);
disp(max3q3);
end

