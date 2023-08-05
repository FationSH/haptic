% Inverse Kin Test

l = 1;

prompt = 'Insert x: ';
x = input(prompt);
prompt = 'Insert y: ';
y = input(prompt);

%%
syms q1 q2
% eqn1 for x and eqn2 for y
 eqns = [l*cos(q1)+l*cos(q2) == x,...
        l*sin(q1)+l*sin(q2) == y];

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