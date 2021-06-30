%Scrpit Draws an arrow
arrow=[0 1 1 3 3 1 1 0;0 1 0.5 0.5 -0.5 -0.5 -1 0]; %assigns a coordinate array to the arrow in the form [x;y]
drawshape(arrow,'g') %calls the drawshape function to draw an arrow
%%%%%%%%%%%%%%%%%%% attempting square drawing%%%%%%%%%%%%%%%%%%
%square=[1 1 2 2 1;1 2 2 1 1];
%drawshape(square)
%axis([0 3 0 3]);
%%%%%%%%%%%%%%%%%%% end square drawing%%%%%%%%%%%%%%%%%%%%%%%%%
%2b
hold on
%Translates the original arrow by 2 in the x and 3 in the y and draws the
%new shape
arrow1=translate(arrow,2,3);
drawshape(arrow1,'r')
%reflects the translated in the y and draws the new shape
arrow2=reflect(arrow1,'y');
drawshape(arrow2,'c')
%reflects the previous arrow in the x and draws the new shape
arrow3=reflect(arrow2,'x');
drawshape(arrow3,'m')
%rotates the previous arrow by pi/4
arrow4=rotate(arrow3,pi/4);
drawshape(arrow4,'b')
axis([-10 10 -10 10])
axis square

