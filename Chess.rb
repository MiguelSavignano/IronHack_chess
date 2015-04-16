
module MoveHelper
	def move_tower(piece_origin,piece_to_go)
			  change_to_i(piece_origin,piece_to_go)
			  @origin_vertical_move==@to_go_vertical_move || @origin_hotizontal_move==@to_go_hotizontal_move
	end
	def move_bishop(piece_origin,piece_to_go)
		change_to_i(piece_origin,piece_to_go)
		  (@to_go_vertical_move-@origin_vertical_move).abs==(@to_go_hotizontal_move-@origin_hotizontal_move).abs
	end
	def move_horse_circle(piece_origin,piece_to_go)
		change_to_i(piece_origin,piece_to_go)
		 (@to_go_vertical_move-@origin_vertical_move).abs<=2 && (@to_go_hotizontal_move-@origin_hotizontal_move).abs<=2
	end
	def move_king(piece_origin,piece_to_go)
		change_to_i(piece_origin,piece_to_go)
		 (@to_go_vertical_move-@origin_vertical_move).abs<=1 && (@to_go_hotizontal_move-@origin_hotizontal_move).abs<=1
	end
	def move_king(piece_origin,piece_to_go)
		change_to_i(piece_origin,piece_to_go)
		 (@to_go_vertical_move-@origin_vertical_move).abs<=1 && (@to_go_hotizontal_move-@origin_hotizontal_move).abs<=1
	end
	def move_pown_white(piece_origin,piece_to_go)
		change_to_i(piece_origin,piece_to_go)
		  @origin_vertical_move==@to_go_vertical_move==-1
	end
	def move_pown_black(piece_origin,piece_to_go)
		change_to_i(piece_origin,piece_to_go)
		  @origin_vertical_move==@to_go_vertical_move==1
	end
end

class Piece
	attr_accessor :origin, :to_go, :origin_vertical_move ,:origin_hotizontal_move,:to_go_vertical_move, :to_go_hotizontal_move
	attr_accessor :draw_piece,:color
	include MoveHelper
	def change_to_i(piece_origin,piece_to_go)
		@origin_vertical_move=piece_origin[0].downcase.ord-96
		@origin_hotizontal_move=piece_origin[1].to_i 
		@to_go_vertical_move=piece_to_go[0].downcase.ord-96
		@to_go_hotizontal_move=piece_to_go[1].to_i 
	end
end

class TowerWhite <Piece
	def initialize
		@draw_piece="wR"
		@color="W"
	end
	def can_move_to(piece_origin,piece_to_go)
		 self.move_tower(piece_origin,piece_to_go)
	end
end

class TowerBlack <TowerWhite
	def initialize
		@draw_piece="bR"
		@color="B"
	end
end

class HorseWhite <Piece
	def initialize
		@draw_piece="wN"
		@color="W"
	end
	def can_move_to(piece_origin,piece_to_go)
		( self.move_horse_circle(piece_origin,piece_to_go) ) && !self.move_tower(piece_origin,piece_to_go)  && !self.move_bishop(piece_origin,piece_to_go)
	end
end

class HorseBlack <HorseWhite
	def initialize
		@draw_piece="bN"
		@color="B"
	end
end

class BishopWhite <Piece
	def initialize
		@draw_piece="wB"
		@color="W"
	end
	def can_move_to(piece_origin,piece_to_go)
		 self.move_bishop(piece_origin,piece_to_go)
	end
end

class BishopBlack <BishopWhite
	def initialize
		@draw_piece="bB"
		@color="B"
	end
end

class QueenWhite <Piece
	def initialize
		@draw_piece="wQ"
		@color="W"
	end
	def can_move_to(piece_origin,piece_to_go)
		self.move_tower(piece_origin,piece_to_go) || self.move_bishop(piece_origin,piece_to_go)
	end
end

class QueenBlack <QueenWhite
	def initialize
		@draw_piece="bQ"
		@color="B"
	end
end

class KingWhite <Piece
	def initialize
		@draw_piece="wK"
		@color="W"
	end
	def can_move_to(piece_origin,piece_to_go)
		self.move_king(piece_origin,piece_to_go)
	end
end

class KingBlack <KingWhite
	def initialize
		@draw_piece="bK"
		@color="B"
	end
end

class PownWhite <Piece
	def initialize
		@draw_piece="wP"
		@color="W"
	end
	def can_move_to(piece_origin,piece_to_go)
		self.move_king(piece_origin,piece_to_go)
	end
end

class PownBlack <Piece
	def initialize
		@draw_piece="bP"
		@color="B"
	end
	def can_move_to(piece_origin,piece_to_go)
		self.move_king(piece_origin,piece_to_go)
	end
end

class Player1
	attr_accessor :color
	def initialize
		@color="W"
	end
	def ask_what_want_move
		puts "Player1: what piece you want to move?"
		gets.chomp
	end
	def ask_where_want_move
		puts "Where piece you want to move?"
		gets.chomp
	end
end

class Player2
	attr_accessor :color
	def initialize
		@color="B"
	end
	def ask_what_want_move
		puts "Player2: what piece you want to move?"
		gets.chomp
	end
	def ask_where_want_move
		puts "Where piece you want to move?"
		gets.chomp
	end
end

class Ouput
	def print_text(text)
		puts text
	end
end

 INITIALIZE_BOARD = {
 "A1" => TowerWhite.new, 
 "B1" => HorseWhite.new,
 "C1" => BishopWhite.new, 
 "D1" => QueenWhite.new, 
 "E1" => KingWhite.new,
 "F1" => BishopWhite.new, 
 "G1" => HorseWhite.new, 
 "H1" => TowerWhite.new, 

 "A8" => TowerBlack.new, 
 "B8" => HorseBlack.new, 
 "C8" => BishopBlack.new, 
 "D8" => QueenBlack.new, 
 "E8" => KingBlack.new,
 "F8" => BishopBlack.new, 
 "G8" => HorseBlack.new, 
 "H8" => TowerBlack.new
}

class NilClass
	def draw_piece
		"--"
	end
end

class Board
	attr_accessor :board, :piece_to_go, :piece_to_go, :piece_in_board,:player_who_game,:player_who_wait
	def initialize(hash_board,white_player,black_player)
		@empty_position="-"
		@player_who_game=white_player
		@player_who_wait=black_player
		@board=hash_board
	end
	def print
			puts "-"*19
			(1..8).each do |num| num=(num-9).abs
				puts "#{num} |#{@board["A#{num}"].draw_piece} #{@board["B#{num}"].draw_piece} #{@board["C#{num}"].draw_piece} #{@board["D#{num}"].draw_piece} #{@board["E#{num}"].draw_piece} #{@board["F#{num}"].draw_piece} #{@board["G#{num}"].draw_piece} #{@board["H#{num}"].draw_piece}|"
			end
			puts "-"*19
			puts "   A  B  C  D  E  F  G  H"
	end
	def change_player(player_who_game)
		@player_who_game=@player_who_wait
		@player_who_wait=player_who_game
	end
	def piece(piece_search)
		piece_in_board=@board[piece_search].draw_piece
	end
	def move_piece(position_origin,position_to_go)
		piece_in_board=@board[position_origin]
		other_piece=@board[position_to_go]
		if  piece_in_board != nil && piece_in_board.color==@player_who_game.color && piece_in_board.can_move_to(position_origin,position_to_go)
			if piece_can_kill(position_origin,position_to_go)
	   			@board[position_to_go]=piece_in_board  
	   			@board[position_origin]=nil
	   			return true
	   		end 
		    return false
		end
		system "clear"
		print
	end
	def piece_can_kill(position_origin,position_to_go)
		other_piece=@board[position_to_go]
		the_piece=@board[position_origin]
		if other_piece==nil 
			true
		else
		    other_piece.color!=the_piece.color
		end
	end
end

board=Board.new(INITIALIZE_BOARD,Player1.new,Player2.new)
output=Ouput.new
while 1==1
	system "clear"
	board.print
	if board.move_piece(board.player_who_game.ask_what_want_move,board.player_who_game.ask_where_want_move)
		output.print_text "Legal move"
		board.change_player(board.player_who_game)
	else 
		output.print_text "Ilegal move"
	end
end
#board.move_piece("A1","A2")