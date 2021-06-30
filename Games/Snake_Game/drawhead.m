function drawhead(theta,x,y)
%draws the snakes head given the front most point and the direction the
%snake is facing(bearing)
shape=head(theta);%generates an array for the shape head facing a given direction
shape=translate(shape,x,y);%translates the shape to the correct position
drawshape(shape,'g')%draws the shape
end

function shape=head(theta)
%generates a head sprite rotated by theta radians
x_rad=0.4; % horizontal radius
y_rad=0.4; % vertical radius
min_angle=-6*pi/7;%minimum angle reached by sector
max_angle=2*pi/7;%maximum angle reached by sector
t1=min_angle:0.005:max_angle;%number of points
t2=pi-max_angle:0.005:pi-min_angle;%number of points
%right arc
x_right=x_rad*cos(t1)+0.5-x_rad;%defining x coordinates based of [a b]=[0 0]
y_right=y_rad*sin(t1)-0.5+y_rad;%defining y coordinates based of [a b]=[0 0]
%left arc
x_left=x_rad*cos(t2)-0.5+x_rad;%defining x coordinates based of [a b]=[0 0]
y_left=y_rad*sin(t2)-0.5+y_rad;%defining y coordinates based of [a b]=[0 0]
shape=[0,x_right,0,x_left,0;-0.5,y_right,0.5,y_left,-.5];%outline shape array
shape=[shape,shape*0.7];%total shape array
shape=rotate(shape,theta);%rotates the shape by theta radians
end