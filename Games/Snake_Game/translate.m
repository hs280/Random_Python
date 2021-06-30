function  newshape=translate(shape,a,b)
%translate a shape by a in the x and b in the y
%  By using indexing ang matrix manipulation the original shape is moved by
%  a in the x and b in the y
x=shape(1,:)+a;%adds a to the x
y=shape(2,:)+b;%adds b to the y 
newshape=[x;y];%combines the 2 row vectors to produce a coordinate array
end

