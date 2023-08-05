function [ R ] = rotateMat( xz, q )

    if xz == 'x'
        R = [1 0 0; 0 cos(q) -sin(q); 0 sin(q) cos(q)];
    elseif xz == 'z'
        R = [cos(q) -sin(q) 0; sin(q) cos(q) 0; 0 0 1];
    else
        %print error
    end
end
