require "./Player"

class Board
    #initializes board for game
	def initialize
		#use 2D array
		@board=[[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]] #we are creating an array with four elements, 
		#each element contains another array of four elements
		@piece=nil #sets piece originally at nil
		@size=0		#defines size originally as 0
	end

	#Prints board with coordinates
	def print_coordinates
		sample_board=[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]
		(0..(sample_board.length)-1).each do |i| #we are assigning the count of each row of the array sample_board 
			#(0,1,2,3) to the variable i
			(0..(sample_board[i].length)-1).each do |j| #we are assigning the count of each column of the array sample_board
				#(0,1,2,3) to the variable j
				if(sample_board[i][j]<10) #adds extra space after single digit numbers to make them the same width as double digits
					marker=sample_board[i][j].to_s + " " #.to_s converts the output of sample_board[i][j] to a string
				else
					marker=sample_board[i][j]
				end
				print "#{marker}"
				print "|" unless j==sample_board.length-1 #prints "|" after each element in the "secondary" arrays (i.e. rows) 
				#except after the last element in each "secondary" array (i.e. each row). 
			end
			puts ""
		end
	end

	#Prints the board, initially will be all 0's and then will reflect X's and O's once game is played.
	def print_board(player=nil) 
		(0..(@board.length)-1).each do |i| 	#we are assigning each row from 0 - 3 (board.length = 4, so 4 - 1 = 3)
			#to the variable i. board.length returns the number of elements in the "primary" array (i.e. the # of rows)
			(0..@board[i].length-1).each do |j| #we are assigning each column from 0 - 3 (board[i].length = 4, so 
				#4 - 1 = 3) to the variable j. board[i].length returns the number of elements in the "secondary"
				#arrays (i.e. the # of columns in each row)
					if(@board[i][j]==0)
						marker="-" #we are telling Ruby that if a cell equals 0, then define marker as equal to "-"
					else
						marker=player.ply_num_to_str(@board[i][j]) #if a cell does not equal 0, 
						#which would happen after a player has put their piece in that cell, then define marker as equal to the 
						#the output of player.ply_num_to_str which will either be X or O. ply_num_to_str is a function under 
						#the Player class; it takes the value a the location board[i][j] (either 1 or 2) and returns a string 
						#either "X" or "O" for that cell. 
					end
				print "#{marker}" #print each element in the "secondary" arrays (the rows) which because of the if 
			    #statement above will either print "-" if the cell is still equal to 0 or will print X or O if the player 
			    #has played in that cell.
          		print "|" unless j==@board.length-1 #prints "|" after each element in the "secondary" arrays (i.e. rows) 
				#except after the last element in each "secondary" array (i.e. each row). 
			end
			puts "" #at the end of each row (technically, it's after each element in the "primary" array), Ruby displays 
		#"" and then adds a line. 
		end
	end

	#Checks that the player's move has not already been made in the game.
	def empty?(location) 
		row=(location-1)/4 #takes the value of location (1-9) and converts it into a row coordinate 0, 1, or 2
		column=(location+3)%4 #takes the value of location (1-9) and converts it into a column coordinate 0, 1, or 2
		return true if @board[row][column]==0 #if the location that the player just entered is equal to 0, which means 
		#it has not been played yet, then return true, otherwise, return false.
		return false
	end

	#Modifies the board to reflect player's input (a number 1-16, defined as location) by changing that cell to be the 
	#the player's number (1 or 2)
	def set_piece(player,location) #takes the arguments player and location
		@piece=player.piece #defines piece as the player's number (either 1 or 2)
		row=(location-1)/4 #takes the value of location (1-16) and converts it into a row coordinate 0, 1, 2, or 3
		column=(location+3)%4 #takes the value of location (1-16) and converts it into a column coordinate 0, 1, 2, or 3
		@board[row][column]=@piece #defines the cell that the player has just selected as the player's number (1 or 2)
		@size+=1 #we count each move after its been made which is used in the function below, check_full?
	end

	#Checks for winner in all scenarious (horizonta, vertical, diagonal) and return true if there is a winner
	def check_win? 
		if check_horizontal_win?||check_vertical_win?||check_diagnal_win? #if one of these functions returns true, 
			#then return true
			return true
		else
			return false
		end
	end
  	
  	#Checks for winner in horizontal scenario, returns true if there is a win
  	def check_horizontal_win? 
    	@board.each do |i| #assigns the elements of the "primary" array in board (i.e. the rows) to the variable i
  	  		if(i[0]!=0&&(i[0]==i[1]&&i[1]==i[2]&&i[2]==i[3])) #if the first element of row i is not equal to 0 and 
  	  			#the first element of row i is equal to the second element of row i and 
  	  			#the second element of row i is equal to the third element of row i and
  	  			#the third element of row i equal to the fourth element of row i, 
  	  			#then by the transitive property the statement is true
        		return true
      		end
  		end
    	return false 
  	end

  	#Checks for winner in vertical scenario, returns true if there is a win
  	def check_vertical_win? 
  		(0...@board.length).each do |i| #assigns the count of rows in the array, board, to the variable i
  			if(@board[0][i]!=0&&(@board[0][i])==@board[1][i]&&@board[1][i]==@board[2][i]&&@board[2][i]==@board[3][i]) 
  			#if the first element of column i is not equal to 0 and 
  			#the first element of column i is equal to the second element of column i and 
  			#the second element of column i is equal to third element of column i and 
  			#the third element of column i is equal to the fourth element, 
  			#then by the transitive property the statement is true
  				return true
  			end
  		end
  		return false
  	end

  	#Checks for winner in diagonal scenario, returns true if there is a win
  	def check_diagnal_win? 
  		first_diag=@board[2][1]!=0&&@board[1][2]!=0&&(@board[3][0]==@board[2][1]&&@board[3][0]==@board[1][2]&&@board[3][0]==@board[0][3]) #if center is not equal to 0, and 
  		#if two center elements from bottom left to top right are not 0 and
  		#bottom left element is equal to center bottom left element and
  		#bottom left element is equal to center top right element and 
  		#bottom left element is equal to top right element then first_diag is equal to true, else equal to false
  		second_diag=@board[1][1]!=0&&@board[2][2]!=0&&(@board[0][0]==@board[1][1]&&@board[0][0]==@board[2][2]&&@board[0][0]==@board[3][3]) #if center is not equal to 0, and
  		#if two center elements from top left to bottom right are not 0 and 
  		#top left element is equal to center top left element and
  		#top left element is equal to center bottom right element and 
  		#top left element is equal to bottom right element then second_diag is equal to true, else equal to false
  		return true if (first_diag||second_diag) #if first_diag is true or second_diag is true, return true. If both are
  		#false, return false.
  		return false
  	end
    
    #Checks to see if every cell is full, and if so, returns true
	def check_full? 
  		return true if @size==16 #size increase by 1 with every turn so when it reaches 16 we know that all cells are full
	end
end