function snake_game_main
%runs snake game press q to quit
%safety very important%%%%%%%%%%%%%%%%%%%%%%%%
warning='WARNING: This video may potentially trigger seizures for people with photosensitive epilepsy. Viewer discretion is advised.\n If you have read this and you accept the risks please type y.\n ';
Wa=input(warning,'s');%requests user to put y
colordef black%
if strcmp('y',Wa)==1 || strcmp('Y',Wa)==1 %if user put y
    ex=0;%don't exit
else
    ex=1;%Should exit
end
if ex==1%if user didnt accept safety warning
    disp('It is inadvisable for you to play this game due to the associated risks')
else
    [ex,Wa,Scr1,scoren]=snake_game(Wa);%run game
end
if ex==1 &&( strcmp('y',Wa)==1 ||strcmp('Y',Wa)==1) %if accepted warning and died
    fatality(Scr1,scoren)%displays death message
end
end
