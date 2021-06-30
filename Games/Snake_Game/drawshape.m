function drawshape(shape,c)
%Plots the outline of a shape when an [x;y] array is given
%   using the plot function and index the drawshape function is able to
%   seperate the x and y coordinates of the shape matrix then plot the
%   coordinates on the cartesian plane,a line is then drawn connecting each
%   point
x=shape(1,:);%genrates an array of x
y=shape(2,:);% generates an array of y
plot(x,y,c)%plots it point by point line graph
end

