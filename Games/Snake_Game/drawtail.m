function drawtail(snake)
%draws the tail for the snake given the snakes coordinates
theta=0;%initialising angle
x_final=snake(end,1);%last x coordinate
y_final=snake(end,2);%last y coordinate
x_pen=snake(end-1,1);%penultimate x coordinate
y_pen=snake(end-1,2);%penultimate y coordinate
if x_final-x_pen==1
    theta=-pi/2; %orientation of tail when snake moves left
elseif x_final-x_pen==-1
    theta=pi/2; %orientation of tail when snake moves right
elseif y_final-y_pen==1
    theta=0; %orientation of tail when snake moves down
elseif y_final-y_pen==-1
    theta=pi; %orientation of tail when snake moves up
end
shape=tail(theta);%rotates tail
shape=translate(shape,x_final,y_final);
drawshape(shape,'g')
end
function shape=tail(theta)
%generates tail spritre rotated theta radians
rad_x=0.4; % horizontal radius
rad_y=0.25; % vertical radius
angle_min=-3*pi/2; %angle range min
angle_max=0;%angle range max
t1=angle_min:0.005:angle_max;%number of points
t2=pi-angle_max:0.005:pi-angle_min;%number of points
%right arc
x_right=rad_x*cos(t1)+0.5-rad_x;%defining x coordinates based of [a b]=[0 0]
y_right=rad_y*sin(t1)-0.5+rad_y;%defining y coordinates based of [a b]=[0 0]
%left arc
x_left=rad_x*cos(t2)-0.5+rad_x;%defining x coordinates based of [a b]=[0 0]
y_left=rad_y*sin(t2)-0.5+rad_y;%defining y coordinates based of [a b]=[0 0]
shape=[0,x_right,0,x_left,0;-0.5,y_right,0.5,y_left,-.5];
shape=rotate(shape,theta);%rotates shape by theta radians
end