require "./Game"

my_game=Game.new
my_game.welcome_message
while(!my_game.check_win&&!my_game.check_full) #while there is no winner and no tie, continue to run the code below
	my_game.enter_move #asks current player to input their move, takes input 
	my_game.place_on_board #checks that the input has not already been given (player has not already selected that cell)
	#and then modifies the board to reflect the current input
	my_game.show_board #prints the board that shows all moves made so far
	if(my_game.check_win) #check if there is a winnner, if so, run code below, otherwise continue game
		my_game.win_message #display message that there is a winner
	elsif(my_game.check_full) #since there is not a winner yet, check if the board is full, if so, run code below, otherwise continue game
		my_game.tie_message #display message that there is a tie
	else #if the conditions have not been satisfied above (no win and no tie), change the current player
		my_game.next_player
	end 
end