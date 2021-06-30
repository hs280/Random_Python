function fatality(Scr1,scoren)
%Writes fatality
%   Death message,shows score and writes fatality
F=[0 0 4.5 4.5 1.5 1.5 4 4 1.5 1.5 0;0 7 7 5.5 5.5 4 4 2.5 2.5 0 0];
A=[0 3.5 5 8 6.5 4.5 4 1.5 0;0 7 7 0 0 6 6 0 0];
T=[0 6.5 6.5 4 4 2.5 2.5 0 0;0 0 -1.5 -1.5 -7 -7 -1.5 -1.5 0];
L=[0 4.5 4.5 1.5 1.5 0 0;0 0 1.5 1.5 7 7 0];
I1=[0 4.5 4.5 3 3 4.5 4.5 0 0 1.5 1.5 0 0;0 0 1.5 1.5 5.5 5.5 7 7 5.5 5.5 1.5 1.5 0];
Y=[0 1.5 2.75 4 5.5 3.5 3.5 2 2 0;0 0 -2 0 0 -3 -7 -7 -3 0]; 
A1=translate(A,3.5,0);
A2=translate(A,14,0);
T1=translate(T,9.5,7);
L1=translate(L,22.5,0);
I2=translate(I1,27.5,0);
T2=translate(T,33,7);
Y1=translate(Y,40,7);
hold on 
colordef black
set(gca,'XTick',[], 'YTick', [])
%set(gca,'DataAspectRatio',[1 1 1])
if Scr1==0;
    set(gca,'DataAspectRatio',[1 1 1])%Maintains Scaling
else
    set(gcf, 'Position', get(0, 'Screensize'))%Makes fullscreen
end
drawshapefill(F,'r')
drawshapefill(A1,'r')
drawshapefill(T1,'r')
drawshapefill(A2,'r')
drawshapefill(L1,'r')
drawshapefill(I2,'r')
drawshapefill(T2,'r')
drawshapefill(Y1,'r')
scores=sprintf('SCORE: %0.0f',scoren);
xlabel(scores,'Color','r')
%%%%%%%%%%%%%%%%%%%%%5Java frame method being removed in future versions of
%%%%%%%%%%%%%%%%%%%%%matlab
%pause(0.00001);
%colordef black
%frame_h = get(handle(gcf),'JavaFrame');
%set(frame_h,'Maximized',1);
 end