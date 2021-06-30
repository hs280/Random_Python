function drawshapefill(shape,c)
%Draws a filled polygon from a set of x and y coordinates
%   Shape is a nx2 array where n is the number of vertices and the first
%   collumn corresponds to x values while the second collumn corresponds to
%   the y values the 
x=shape(1,:);
y=shape(2,:);
fill(x,y,c)
end