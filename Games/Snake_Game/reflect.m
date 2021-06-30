function newshape=reflect(shape,a)
%reflects a shape about a defined axis axis
%   refrects a matrix array representing a shape in the line y=0
a1=double(a);
if a1==double('x') || a1==double('X')
    newshape=reflectx(shape);%calls reflect in x function 
else
    newshape=reflecty(shape);%calls reflect in y function 
end
end
function newshape=reflecty(shape)
%reflects a shape about the y axis
%   reflects a matrix array representing a shape in the line x=0
ty=[-1 0;0 1];%the y transformation matrix
newshape=ty*shape;%generates a coordinate array for the new shape
end

function newshape=reflectx(shape)
%reflects a shape about the x axis
%   reflects a matrix array representing a shape in the line y=0
tx=[1 0;0 -1];%the x transformation matrix
newshape=tx*shape;%generates a coordinate array for the new shape
end
