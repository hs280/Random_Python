function newshape = rotate(shape,a)
%rotates a shape by a radians
%   using matrix multiplication the original shape is rotated by an angle
%   of a about the origin counterclockwise
ta=[cos(a) -sin(a);sin(a) cos(a)];%generic rotation matrix
newshape=ta*shape;%new coordinate array
end

