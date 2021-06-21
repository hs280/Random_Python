# -*- coding: utf-8 -*-
"""
Created on Mon Jun 21 15:12:33 2021

@author: Omen
"""

 
from random import randint

def user_interface(option_list):
    '''
    function presenting options and asking for player feedback
    returns integer.
    '''
    for index,option in enumerate(option_list):
        print(f'{index} = {option}')

    user_input = int(input('What do you choose? '))
    return user_input


def computer_choice(option_list):
    '''
    function that generates a random number based on the available options.
    returns random int
    '''
    computer_chose = randint(0,len(option_list)-1)
    return computer_chose
    

def check_results( player, computer,logic_chain):
    '''
    function that checks who won.
    returns string
    '''
    if player == computer:
        result= ("It\'s a tie",0)
    elif computer in logic_chain :
        result= ("Player Lost",-1)
    else :
        result= ("Player Win",1)
    return result


def play(option_list,logic_list):
    game_type=' '.join(option_list)
    print('''
    ---------------------------------
    Please pick your weapon.
    ''')

    ## ask player to pick
    player_result = user_interface(option_list)
    ## computer pick
    computer_result = computer_choice(option_list)
    
    #viusual representation in the terminal so we can see what both parties chose
    print(f'  player chose: {option_list[player_result]}    \n')
    print(f'computer chose: {option_list[computer_result]}  \n')

    #check the results between the two and print the winner.
    result = check_results(player_result,computer_result,logic_list[player_result])
    return result
    #print (f'\n{results}')

def main():
    option_list = ['Rock', 'Paper' , 'Scissors' , 'Lizard' ,'Spock']
    logic_list = [[1.4],[2,3],[4,0],[0,2],[3,1]]
    #force the player into the play loop
    current_score = 0
    play_again = ''
    game_type=' '.join(option_list)
    print('''
    ---------------------------------
    Welcome to %s .''' % game_type)
    
    while play_again.lower() != 'n':
        result=play(option_list,logic_list)
        current_score = current_score+result[1]
       
        
        if current_score > 0:
            state='the Player is winning by '+str(current_score)
        elif current_score<0:
            state='the Player is losing by '+str(-1*current_score)
        else:
            state = 'It is a draw overall'
            
            
        print(' and '.join([result[0],state]))
        print (f'Do you want to play again? ')
        play_again = input('type \'y\' for yes or \'n\' for no: ')
        
    print('The player' + (current_score>0)*(' won by '+str(current_score))+ (current_score<0)*(' lost by '+str(-1*current_score))+(current_score==0)*(' drew'))
        
    
main()