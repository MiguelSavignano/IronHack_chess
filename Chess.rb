require 'pry'
class NilClass
	def draw_piece
		"--"
	end
end
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
end
class Board
	attr_accessor :board, :piece_to_go, :piece_to_go, :piece_in_board
	def initialize(hash_board)
		@empty_position="-"
		@board=hash_board
	end
	def print
			puts "-"*19
			puts "#{8} |#{@board["A8"].draw_piece} #{@board["B8"].draw_piece} #{@board["C8"].draw_piece} #{@board["D8"].draw_piece} #{@board["E8"].draw_piece} #{@board["F8"].draw_piece} #{@board["G8"].draw_piece} #{@board["H8"].draw_piece}|"
			puts "#{7} |#{@board["A7"].draw_piece} #{@board["B7"].draw_piece} #{@board["C7"].draw_piece} #{@board["D7"].draw_piece} #{@board["E7"].draw_piece} #{@board["F7"].draw_piece} #{@board["G7"].draw_piece} #{@board["H7"].draw_piece}|"
			puts "#{6} |#{@board["A6"].draw_piece} #{@board["B6"].draw_piece} #{@board["C6"].draw_piece} #{@board["D6"].draw_piece} #{@board["E6"].draw_piece} #{@board["F6"].draw_piece} #{@board["G6"].draw_piece} #{@board["H6"].draw_piece}|"
			puts "#{5} |#{@board["A5"].draw_piece} #{@board["B5"].draw_piece} #{@board["C5"].draw_piece} #{@board["D5"].draw_piece} #{@board["E5"].draw_piece} #{@board["F5"].draw_piece} #{@board["G5"].draw_piece} #{@board["H5"].draw_piece}|"
			puts "#{4} |#{@board["A4"].draw_piece} #{@board["B4"].draw_piece} #{@board["C4"].draw_piece} #{@board["D4"].draw_piece} #{@board["E4"].draw_piece} #{@board["F4"].draw_piece} #{@board["G4"].draw_piece} #{@board["H4"].draw_piece}|"
			puts "#{3} |#{@board["A3"].draw_piece} #{@board["B3"].draw_piece} #{@board["C3"].draw_piece} #{@board["D3"].draw_piece} #{@board["E3"].draw_piece} #{@board["F3"].draw_piece} #{@board["G3"].draw_piece} #{@board["H3"].draw_piece}|"
			puts "#{2} |#{@board["A2"].draw_piece} #{@board["B2"].draw_piece} #{@board["C2"].draw_piece} #{@board["D2"].draw_piece} #{@board["E2"].draw_piece} #{@board["F2"].draw_piece} #{@board["G2"].draw_piece} #{@board["H2"].draw_piece}|"
			puts "#{1} |#{@board["A1"].draw_piece} #{@board["B1"].draw_piece} #{@board["C1"].draw_piece} #{@board["D1"].draw_piece} #{@board["E1"].draw_piece} #{@board["F1"].draw_piece} #{@board["G1"].draw_piece} #{@board["H1"].draw_piece}|"
			puts "-"*19
			puts "   A  B  C  D  E  F  G  H"
	end
	def piece(piece_search)
		piece_in_board=@board[piece_search].draw_piece
	end
	def move_piece(position_origin,position_to_go)
		piece_in_board=@board[position_origin]
		other_piece=@board[position_to_go]
		if  piece_in_board != nil && piece_in_board.can_move_to(position_origin,position_to_go)    
			if piece_can_kill(position_origin,position_to_go)
		   		@board[position_to_go]=piece_in_board  
		   		@board[position_origin]=nil
		   end 
		end
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
class TowerBlack <Piece
	def initialize
		@draw_piece="bR"
		@color="B"
	end
	def can_move_to(piece_origin,piece_to_go)
		 self.move_tower(piece_origin,piece_to_go)
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
class HorseBlack <Piece
	def initialize
		@draw_piece="bN"
		@color="B"
	end
	def can_move_to(piece_origin,piece_to_go)
		( self.move_horse_circle(piece_origin,piece_to_go) ) && !self.move_tower(piece_origin,piece_to_go)  && !self.move_bishop(piece_origin,piece_to_go)
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
class BishopBlack <Piece
	def initialize
		@draw_piece="bB"
		@color="B"
	end
	def can_move_to(piece_origin,piece_to_go)
		 self.move_bishop(piece_origin,piece_to_go)
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
class QueenBlack <Piece
	def initialize
		@draw_piece="bQ"
		@color="B"
	end
	def can_move_to(piece_origin,piece_to_go)
		self.move_tower(piece_origin,piece_to_go) || self.move_bishop(piece_origin,piece_to_go)
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
class KingBlack <Piece
	def initialize
		@draw_piece="bK"
		@color="B"
	end
	def can_move_to(piece_origin,piece_to_go)
		self.move_king(piece_origin,piece_to_go)
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
 "E8" => KingBlack.	new,
 "F8" => BishopBlack.new, 
 "G8" => HorseBlack.new, 
 "H8" => TowerBlack.new
}
board=Board.new(INITIALIZE_BOARD)
board.print

binding.pry
#board.print print board instance
#board.piece("B1") search piece in board
#board.move_piece("A1","A2") board move