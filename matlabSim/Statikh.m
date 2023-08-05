function [ t ] = Statikh( J, F )

Jt = J.';
t = Jt*F;

end
