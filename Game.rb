require "./Player"
require "./Board"

class Game
	#Initializes the game by creating the new instances of the classes below
	def initialize
		@my_board=Board.new 	#we define the internal variable, my_board, as an instance of the class Board
		@player1=Player.new(1, @name1)	#we define the internal variable, player1, as an instance of the class Player
		@player2=Player.new(2, @name2)	#we define the internal variable, player2, as an instance of the class Player
		@current=@player1		#we define the internal variable, current, as player1
		@location=nil			#we define the internal variable, location, as nil
	end

	#Prints welcome message and prints board
	def welcome_message
		puts ""
		puts "Welcome to the game, Flatiron School! We will need two players for this game.\nPlayer 1, what is your name?"
		@player1.name = gets.chomp
		puts ""
		puts "Welcome, #{@player1.name}. Player 2, what is your name?"
		@player2.name = gets.chomp
		puts ""
		puts "Welcome, #{@player2.name}."
		puts "\n"
		puts "Before we get started, you should know this is not a typical game of tic tac toe."
		puts "It is actually called tic tac toe too and it's played on a 4 x 4 grid."
		puts "Here's what it looks like:"
		@my_board.print_board 
		puts ""
		puts "You make your move by entering in the cell number of the cell you want.\nHere's a little map to help you:"
		@my_board.print_coordinates
		puts ""
		puts "Good luck!"
		puts ""
	end

	#Asks the current player to make their move and takes the input from the player 
	def enter_move
		print "#{@current.name}, it's your move. Select a location to place your piece by entering 1-16:" 
		puts ""
		@location=gets.chomp.to_i #location is defined as the players input (an integer from 1-16). We use .chomp because the 
		#default of gets is to add a new line after the variable. By using .chomp we remove the new line that will be printed.
		#we use .to_i to convert the input which is originally a string into an integer.	
	end

	#Takes the player's input (location), confirms that move has not already been made, modifies the board to reflect that move
	def place_on_board
		while(!@my_board.empty?(@location)) #while the location the player selected has already been taken,
			#then display the message below and take the player's input as the new location.
			print "Seats taken! You better select another location between 1-16"
			puts ""
			@location=gets.chomp.to_i #location is defined as the players input (an integer from 1-16). 	
		end
		@my_board.set_piece(@current,@location) #if the location of the player has not already been taken, 
			#then modify board to reflect their move on the board using the function set_piece.
	end

	#Prints the board to reflect the move just made by the current player. 
	def show_board
		@my_board.print_board(@current) #the function .print_board takes the argument current which is equal to the current 
		#player id
	end

	#Checks to see if there is a winner, returns true if there is a winner
	def check_win
		return @my_board.check_win? #this may seem redundant but because tic_tac_toe.rb does not require Board.rb, we need 
		#to define this function.
	end

	#Puts message that the a player has won 
	def win_message 
		if(@current==@player1)
			puts "#{@current.name} wins! #{@player2.name}, you should challenge #{@current.name} to a rematch."
		else
			puts "#{@current.name} wins! #{@player1.name}, you should challenge #{@current.name} to a rematch."
		end
	end

	#Checks to see if there is a tie based on if all cells are full, returns true if there is a tie
	def check_full
		return @my_board.check_full?
	end

	#Puts message that there is a tie
	def tie_message
		puts "It's a cat's game! Better play again." 
	end

	#Switches the current player to the other player
	def next_player 
		if(@current==@player1)
			@current=@player2
		else
			@current=@player1
		end
	end
end