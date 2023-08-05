l = 1;

prompt = 'Insert x: ';
x = input(prompt);
prompt = 'Insert y: ';
y = input(prompt);
prompt = 'Insert z: ';
z = input(prompt);
    
% eqn1 for x, eqn2 for y and eqn3 for z
r = sqrt(x^2+y^2+z^2);
q3f = radtodeg(asin(z/(r)));

% if x > 0
%     theta = radtodeg(atan(y/x));
% elseif x == 0
%     theta = radtodeg(sign(y))*deg2rad(pi/2);
% elseif x < 0
%     if y >= 0
%         theta = radtodeg(atan(y/x))+deg2rad(pi);
%     else
%         theta = radtodeg(atan(y/x))-deg2rad(pi);
%     end
% end



% ta x & y pou exei an paei stis 2 diastaseis
x2d = r*cos(theta);
y2d = r*sin(theta);

%%
syms q1 q2
% eqn1 for x and eqn2 for y
eqns = [l*cos(q1)+l*cos(q2) == x2d,...
        l*sin(q1)+l*sin(q2) == y2d];

s = solve(eqns, q1, q2);

q1 = s.q1;
q2 = s.q2;

q1deg = double(radtodeg(vpa(q1)));
q2deg = double(radtodeg(vpa(q2)));

%% there are two solutions, q1 < q2 && q1 > q2
%  always q1 < q2 

if q1deg(1) < q2deg(1)
    q1f = q1deg(1); q2f = q2deg(1);
else
    q1f = q1deg(2); q2f = q2deg(2);
end

q1f
q2f
q3f