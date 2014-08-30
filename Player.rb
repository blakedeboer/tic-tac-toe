class Player
	attr_accessor :piece, :name #we make the instance variables, piece and name, readable and writable

	def initialize(num, name) #we are settig up an internal variable, piece, in the class Player
		@piece=num #the piece variable is defined as the player number, either 1 or 2
	end

	#Takes players move which will be an integer (1 or 2) and converts to X or O
	def ply_num_to_str(num) #takes the player choice, the value of cell located at board[i][j] which 
		#will either be 1 or 2, and returns string representation of player
		if(num==1) 
			return "X" #if a cell is equal to 1, then this function returns X
		else
			return "O" #if a cell is equal to 2, then this function returns O	
		end
	end
end