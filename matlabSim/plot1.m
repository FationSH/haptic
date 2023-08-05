function [ ] = plot1( l, q1, q2, q3 )

[q1, q2, q3] = toRad(q1, q2, q3);

% x = l*cos(q1)+l*cos(q1+q2);
% y = l*sin(q1)+l*sin(q1+q2);
% r = sqrt(x^2+y^2);

% q2t = q2/2;
% ze = r*sin(q3);
% xe = r*cos(q1+q2t)*cos(q3);
% ye = r*sin(q1+q2t)*cos(q3);

%% NEW
x = l*cos(q1)+l*cos(q2);
y = l*sin(q1)+l*sin(q2);
r = sqrt(x^2+y^2);

q2t = (q2-q1)/2;
ze = r*sin(q3);
xe = r*cos(q1+q2t)*cos(q3);
ye = r*sin(q1+q2t)*cos(q3);

% % plot
X=[0,xe];Y=[0,ye];Z=[0,ze];
plot3(X,Y,Z,...
'Marker','o','LineStyle','-');
grid; % Add grid lines to the current axes.
xlabel('x');ylabel('y');zlabel('z');

disp('Teliko shmeio xe, ye, ze :');
disp(xe);
disp(ye);
disp(ze);

end
