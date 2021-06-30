function [ex,Wa,Scr1,score_number]=snake_game(Wa)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     PRESS 'Q' TO EXIT GAME         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
ex=0;    % used to exit game
%%
% OPTIONS
pD='How hard do you want the game to be(1-10)?\n';%message for game difficulty
pW='Do you want hard walls(y/n)?\n';%message for wall status
pA='How large do you want the map to be(xl,l,m,s,xs)?\n';
pScr='Do you want to play full screen(y/n)?\n';
difficulty=input(pD,'s');%Difficulty input
W=input(pW,'s');%Hard walls input
A=input(pA,'s');%Map size input
Scr=input(pScr,'s');%Full screen input
%wall status if statement
if double(W)==double('y')%if user input y
    wall_logical=1;
else % if user didnt input y
    wall_logical=0;
end
%Screen size if statement
if double(Scr)==double('y')%if the user inputs y they have selected full screen
    Scr1=1;%fullscreen==true logical
else
    Scr1=0;%fullscreen==false logical
end
%code determining map size
if strcmp(A,'xl')==1 %Extra Large
    axis_limit=50;
elseif strcmp(A,'l')==1 %Large
    axis_limit=40;
elseif strcmp(A,'m')==1 %Medium
    axis_limit=30; %small
elseif strcmp(A,'s')==1 %Small
    axis_limit=20;
elseif strcmp(A,'xs')==1 %Extra Small
    axis_limit=10;
else %if the user inputs something else
    axis_limit=randi([1,5])*10;%Random sized map
end
difficulty=str2double(difficulty); %Making difficulty a number
%setting it so that difficulty is between 1 and 10 and is an integer
if difficulty>10 %if the user inputs a D more than max starting difficulty, cap to 10
    difficulty=10;
elseif difficulty<1 %If the user inputs a difficulty less than min starting difficulty, cap to 1
    difficulty=1;
elseif 0<difficulty %if the user inputs a number within the range
    difficulty=round(difficulty);
else %if the user input is not a number
    difficulty=randi([2;7]); %random difficulty less than 8
end
%user input end
%% 
%%%%%%%%%%%%%%%%%%%%%Initialising values
d=0;%initialised snake direction
score_number=0;%Defining initial score
score_string='SCORE: 0'; %Score description at start
initial_x =round(axis_limit/2); %centre point x
initial_y =round(axis_limit/2); %centre point y
d =randi([1,4]);% generates random direction to start in for snake
food_x =randi([1 axis_limit-1],1);%generates random x coordinate for food
food_y =randi([1 axis_limit-1],1);%generates random y coordinate for food
snake(1,1:2)=[initial_x initial_y];%defines the snake for x and y coordinates
%defining food and creature parameters
ate=1;   %snake ate food
food=[food_x food_y];%defines food for a and b coordinates
horizontal_radius=0.3; %horizontal radius
vertical_radius=0.5; %vertical radius
food_resoloution=-pi:0.05:pi;%number of points
food_x_array=horizontal_radius*cos(food_resoloution);%defining x coordinates based of [a b]=[0 0]
food_y_array=vertical_radius*sin(food_resoloution);%defining y coordinates based of [a b]=[0 0]
Should_creature_spawn=0;%should creature spawn
is_creature_spawned=0;%creature spawned logical
theta=0;%angle creature is facing,negative bearing
creature_movement_iteration=0;%Creature movement iteration factor
Case_for_creature_movement=1;%switch for creature movement
%Miscellaneous initial settings
pause_factor=0.036+(10-difficulty)*0.006;%Pause factor
Score_offset=0; %initial Score offset
max_size=50;%50 is max usable 3 is min, maximum size before creature is spawned
figure('KeyPressFcn',@my_callback);
creature=(1/8)*[0,1,1,4,4,1,1,-1,-1,-4,-4,-1,-1,0;-4,-3,-1,-4,-1,3,4,4,3,-1,-4,-1,-3,-4];%defines creature shape
maxdiff=20; %Last difficulty where length will reset
diff_string=sprintf('DIFFICULTY: %0.0f',difficulty); %startng difficulty string form
if Scr1==0
    set(gca,'DataAspectRatio',[1 1 1])%Maintains scaling
else
    set(gcf, 'Position', get(0, 'Screensize'))%Makes fullscreen
end
movegui('center')%centers figure
%%
    function my_callback(var, event)%callback function for movement
        switch event.Character
            case 'q'
                ex=1;%quits game
                Wa=1;
            case 30               % arrow direction
                if(d~=2) && snake(1,2)-snake(2,2)~=-1 %if movement will not cause death
                    d = 1;              %up d=1
                end
            case 31
                if(d~=1) && snake(1,2)-snake(2,2)~=1 %if movement will not cause death
                    d = 2;              %down d=2
                end
            case 29
                if(d~=4) && snake(1,1)-snake(2,1)~=-1 %if movement will not cause death
                    d = 3;              %right d=3
                end
            case 28
                if(d~=3) && snake(1,1)-snake(2,1)~=1 %if movement will not cause death
                    d = 4;              %left d=4
                end
        end
    end
%%
while (ex~=1)%runs the snake as long as q is not pressed
    size_snake=size(snake);
    size_snake=size_snake(1);
    for z=size_snake+ate:-1:2
        snake(z,:)=snake(z-1,:);%moves snake forward one frame
    end
    m=snake';
    switch d %calling callback function
        case 1
            m(:,1)=translate(m(:,1),0,1);%add value of 1 to y position
            alpha=0;%head facing up
        case 2
            m(:,1)=translate(m(:,1),0,-1);%subtract value of 1 to y position
            alpha=pi;%head facing down
        case 3
            m(:,1)=translate(m(:,1),1,0);%add value of 1 to x position
            alpha=-pi/2;%head facing right
        case 4
            m(:,1)=translate(m(:,1),-1,0);%subtracts value of 1 to x position
            alpha=pi/2;%head facing left
    end
    if Should_creature_spawn==1 %if creature should be spawned
        exc1=1; %can move left
        exc2=2; %can move right
        exc3=3; %can move down
        exc4=4; %can move up
        if is_creature_spawned==0 %if creature has just been spawned
            food_x=food(1);%xpos
            food_y=food(2);%ypos
            is_creature_spawned=1; %creature not just spawned
        end
        if food_x<=1 %creature at or below low x bound
            exc1=[];%can't move left
        end
        if food_x>=axis_limit-1 %creature at or above up x bound
            exc2=[];%can't move right
        end
        if food_y<=1 %creature at or below low y bound
            exc3=[];%can't move down
        end
        if food_y>=axis_limit-1 %creature at or above up y bound
            exc4=[];%can't move up
        end
        if any(snake==[food_x-1 food_y])==[1 1]%if would collide with snake by going left
            exc1=[];%can't move left
        end
        if any(snake==[food_x+1 food_y])==[1 1]%if would collide with snake by going right
            exc2=[];%can't move right
        end
        if any(snake==[food_x food_y-1])==[1 1]%if would collide with snake by going down
            exc3=[];%can't move down
        end
        if any(snake==[food_x food_y+1])==[1 1]%if would collide with snake by going up
            exc4=[]; %can't move up
        end
        mc=[exc1 exc2 exc3 exc4];%array with possible values for dc
        if size(mc)~=[0 0] %if safe movement of the creature is possible
            if any(mc==Case_for_creature_movement) && creature_movement_iteration<4 %if continued movement in the same direction is possible without death & has changed direction
                creature_movement_iteration=creature_movement_iteration+1; %increase iteration count for non changed movement vector
            else
                Case_for_creature_movement=mc(randi(numel(mc))); %Change direction switch
                creature_movement_iteration=0; %reset iteration count
            end
        else
            Case_for_creature_movement=0; %neutral
        end
        switch Case_for_creature_movement
            case 1
                food_x=food_x-1;%subtract value of 1 to x position
                theta=pi/2; %facing left
                %pause(0.01) %add delay
            case 2
                food_x=food_x+1;%add value of 1 to x position
                theta=-pi/2; %facing right
                %pause(0.01) %add delay
            case 3
                food_y=food_y-1;%subtract value of 1 to y position
                theta=pi; %facing down
                %pause(0.01) %add delay
            case 4
                food_y=food_y+1;%add value of 1 to y position
                theta=0; %facing up
                %pause(0.01) %add delay
        end
    end
    if size_snake==max_size || difficulty>=maxdiff %if at max size or difficulty high
        Should_creature_spawn=1; %creature should be spawned
    end
    snake=m';%transposing the snake matrix so can use translate function
    [score_string,score_number,snake,pause_factor,Score_offset,difficulty,diff_string]=draw_s(snake,food,size_snake,wall_logical,axis_limit,food_x_array,food_y_array,difficulty,score_number,score_string,pause_factor,Score_offset,Should_creature_spawn,food_x,food_y,max_size,creature,theta,maxdiff,diff_string,alpha,ate);%draws the snake
    axisself([-0.5, axis_limit+0.5, -0.5, axis_limit+0.5])%creates the axis for gameplay%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    set(gca,'XTick',[], 'YTick', [])%remove axis labels%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    xlabel(score_string) %displays the current score
    ylabel(diff_string) %Displays the current level
    title(' SN{\Lambda}K{\Sigma} ','Color','r')%Makes cool looking title
    pause(pause_factor) %diffculty makes game faster;
    if (snake(1,1)==food(1) && snake(1,2)==food(2) && Should_creature_spawn~=1)||(snake(1,1)==food_x && snake(1,2)==food_y && Should_creature_spawn==1)%if the snake and food are in the same position
        ate=1; %Snake has eaten food
        is_creature_spawned=0; %number of creature iterations =0
        food(1) = randi([1 axis_limit-1]);%creates a new x position for the food
        food(2) = randi([1 axis_limit-1]);%creates a new y position for the food
        if ismember(food,snake,'rows')==1
            all_snake_x=(snake(:,1))';%generates an array of the snakes x coordinates
            all_snake_y=(snake(:,1))';%generates an array of the snakes y coordinates
            free_x=setdiff(1:axis_limit-1,all_snake_x);%generates an array of empty x
            free_y=setdiff(1:axis_limit-1,all_snake_y);%generates an array of empty y
            number_of_free_x=numel(free_x);%the number of free collumns
            number_of_free_y=numel(free_y);%the number of free rows
            if number_of_free_x==0 && number_of_free_y~=0
                food(2)=free_y(randi(numel(free_y)));%creates a new y position for the food
            elseif number_of_free_y==0 && number_of_free_x~=0
                food(1)=free_x(randi(numel(free_x)));%creates a new x position for the food
            elseif number_of_free_x~=0 && number_of_free_y~=0 %if both aren't 0
                randx=randi([1,3]);%generates a randomiser variable
                if randx==1 %case 1
                    food(1)=free_x(randi(numel(free_x)));%creates a new x position for the food
                elseif randx==2 %case 2
                    food(2)=free_y(randi(numel(free_y)));%creates a new y position for the food
                else %case 3
                    food(1)=free_x(randi(numel(free_x)));%creates a new x position for the food
                    food(2)=free_y(randi(numel(free_y)));%creates a new y position for the food
                end
            end
        end
    else
        ate=0;%hasnt just eaten food
    end
    if size_snake==max_size || difficulty>=maxdiff %difficulty graeter than or equal to max difficulty or size=max size
        Should_creature_spawn=1; %should spawn creature
    else
        Should_creature_spawn=0;%shouldnt spawn creature
    end
    %bounds;
    if wall_logical==1
        snake(1,:);
        if snake(1,1)==0 %if snake exceeds boundaries display message
            ex=1;
        elseif snake(1,2)==0%if snake exceeds boundaries display message
            ex=1;
        elseif snake(1,1)==axis_limit%if snake exceeds boundaries display message
            ex=1;
        elseif snake(1,2)==axis_limit%if snake exceeds boundaries display message
            ex=1;
        end
    else
        snake=snake-((snake>axis_limit).*(axis_limit+1));%loop around
        snake=snake+((snake<0).*(axis_limit+1));
    end
    if (sum(snake(:, 1) ==snake(1, 1)   & snake(:, 2) == snake(1, 2) )>1) %if snake hits itself%%%%%%%%%%%sometimes false fires
        ex=1;
        %breaks
    end
    
    
end
close all
end
%%
function [score_string,score_number,snake,pause_factor,score_offset,difficulty,diffs]=draw_s(snake,food,size_snake,w1,axis_limit,food_x_array,food_y_array,difficulty,score_number,score_string,pause_factor,score_offset,should_spawn_creature,food_x,food_y,max_size,creature,theta,maxdiff,diffs,alpha,ate)
%draws snake and figure
hold off
if score_number~=((size_snake-2)*difficulty)*(w1+1)+score_offset
    scorea=((size_snake-2)*difficulty)*(w1+1);%unoffset score calculator
    score_number=scorea+score_offset;%actual score
    score_string=sprintf('SCORE: %0.0f',score_number);%Displayed message
end
if size_snake>max_size && difficulty<maxdiff %if size reset should occur
    size_snake=2; %reset size
    score_offset=score_offset+scorea; %new offset value
    difficulty=difficulty+1;%increase difficultyn
    score_string=sprintf('SCORE: %0.0f',score_number);%displayed score message
    diffs=sprintf('DIFFICULTY: %0.0f',difficulty);%displayed difficulty message
end

if w1==1 %walls are present
    drawshape([0 0 axis_limit axis_limit 0;0 axis_limit axis_limit 0 0],'r') %draws walls
    hold on
end
if should_spawn_creature~=1 %creature not meant to be drawn
    drawfood(food,food_x_array,food_y_array)%draw foood
else
    drawc(food_x,food_y,creature,theta) %draw creature
end
hold on
if size_snake~=2 && ate~=1 %if not just eaten food
    for p = 2:size_snake-1 %draw snake body for each snake point apart from head and tail
        drawbod(snake(p,:)','g')%draws the body
    end
elseif ate==1 %if just eaten food
    for p = 2:size_snake %draw snake body for each snake point apart from head and old tail
        drawbod(snake(p,:)','g')%draws body
    end
end
drawhead(alpha,snake(1,1),snake(1,2))%draws head
drawtail(snake) %draws tail
hold off
end
%%
function drawbod(point,color)
%draws a unit body block
unit1=[0.3,0.5,0.5,0.3,-0.3,-0.5,-0.5,-.3,.3;-.5,-.3,.3,.5,.5,.3,-.3,-.5,-.5];%defines outer body shape
unit2=unit1*0.35;%snake unit inner body shape
ax=point(1,1);%x coordinate
ay=point(2,1);%y coordinate
snak1=translate(unit1,ax,ay);%move unit to correct point
drawshape(snak1,color)%draw unit moved
hold on
snak2=translate(unit2,ax,ay);%move unit to correct point
drawshape(snak2,color)%draw unit moved
end
%%
function drawfood(food,x_array,y_array)
%draws food at a given point
x0=food(1,1); % x0,y0 ellipse centre coordinates
y0=food(1,2);
x=x0+x_array; %an array of values for x and y
y=y0+y_array;
f=[x;y];%the full coordinate array
drawshapefill(f,'r')%draw a filled red circle
end
%%
function drawc(a,b,creature,theta)
creature=rotate(creature,theta);%rotate creature so facing correct direction
creature1=translate(creature,a,b);%move creature
drawshape(creature1,'c')%draw creature
end
%%