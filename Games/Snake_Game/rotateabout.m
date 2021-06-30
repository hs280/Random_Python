function newshape = rotateabout(shape,a,x,y)
%Rotates a shape[x;y] angle a about x,y
%   Detailed explanation goes here
s1=translate(shape,-x,-y);%translates the shape such that the new origin is the rotational centre
s2=rotate(s1,a);%rotates the newshape
newshape=translate(s2,x,y);%returns the shape to its original position with regards to the original origin
end

