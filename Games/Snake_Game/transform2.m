arrow=[0 1 1 3 3 1 1 0;0 1 0.5 0.5 -0.5 -0.5 -1 0]; %assigns a coordinate array to the arrow in the form [x;y]
n1=inputdlg('What is n'); %Requests n from the user
n=str2double(n1{1}); %converts n to a double
t1=inputdlg('What is t'); %requests t (the pause time) from user
t=str2double(t1{1}); %converts t to a double
x=linspace(0,2*pi,n); %generates an array for x linearly spaced
for k=1:n %generates an array for k
    r=x(k); %indexes x with k
    a1=rotateabout(arrow,r,1.5,-4); %rotates about point (1.5,-4) by k*(2pi/n)
    drawshape(a1,'b') %draws the rotated shape
    axis([-10 10 -10 10]) %sets axis 
    axis square
    drawnow %causes the figure to be made on each loop
    pause(t) %waits t seconds till next loop
end