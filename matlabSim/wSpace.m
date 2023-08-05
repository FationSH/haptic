function [  ] = wSpace( l )

X=[];Y=[];Z=[];
i=1;
%hold on
for q1=10:5:160
    q1r = q1*(pi/180);
    for q2=(q1+10):5:170 % q2 >= q1+10 panta
%       if q1 < 90       Gia na deite stous a3ones z-x
%           q2 = 2*(90-q1);
        q2r = q2*(pi/180);
        for q3=0:5:70
            q3r = q3*(pi/180);
            x = l*cos(q1r)+l*cos(q2r);
            y = l*sin(q1r)+l*sin(q2r);
            r = sqrt(x^2+y^2);
            q2t = (q2r-q1r)/2;
            
            ze = r*sin(q3r);
            xe = r*cos(q1r+q2t)*cos(q3r);
            ye = r*sin(q1r+q2t)*cos(q3r);
            X(i)=xe;
            Y(i)=ye;
            Z(i)=ze;
            i=i+1;
%             plot3(xe, ye, ze, ...
%                 'Marker','o','LineStyle','-');
       end
       for q3=290:5:360
            q3r = q3*(pi/180);
            x = l*cos(q1r)+l*cos(q2r);
            y = l*sin(q1r)+l*sin(q2r);
            r = sqrt(x^2+y^2);
            q2t = (q2r-q1r)/2;
            
            ze = r*sin(q3r);
            xe = r*cos(q1r+q2t)*cos(q3r);
            ye = r*sin(q1r+q2t)*cos(q3r);
            X(i)=xe;
            Y(i)=ye;
            Z(i)=ze;
            i=i+1;
%             plot3(xe, ye, ze, ...
%                 'Marker','o','LineStyle','-');
        end
    end
end
% grid; % Add grid lines to the current axes.
% xlabel('x');ylabel('y');zlabel('z');
% hold off

T=delaunay(X,Y,Z);
colormap winter
%Plot the surface
trisurf(T,X,Y,Z,'FaceColor','interp','FaceLighting','phong');
shading interp

end

