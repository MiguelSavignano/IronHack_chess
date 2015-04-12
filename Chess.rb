require 'pry'
class NilClass
	def draw_piece
		"-"
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
			puts "   A B C D E F G H "
	end
	def piece(piece_search)
		piece_in_board=@board[piece_search].draw_piece
	end
	def move_piece(position_origin,position_to_go)
		piece_in_board=@board[position_origin]
		if piece_in_board != nil && piece_in_board.can_move_to(position_origin,position_to_go)
		   @board[position_to_go]=piece_in_board  
		   @board[position_origin]=nil 
		end
		print
	end
end
class Piece
	attr_accessor :origin, :to_go, :origin_vertical_move ,:origin_hotizontal_move,:to_go_vertical_move, :to_go_hotizontal_move
	attr_accessor :draw_piece
	include MoveHelper
	def change_to_i(piece_origin,piece_to_go)
		@origin_vertical_move=piece_origin[0].downcase.ord-96
		@origin_hotizontal_move=piece_origin[1].to_i 
		@to_go_vertical_move=piece_to_go[0].downcase.ord-96
		@to_go_hotizontal_move=piece_to_go[1].to_i 
	end
end
class Tower <Piece
	def initialize
		@draw_piece="R"
	end
	def can_move_to(piece_origin,piece_to_go)
		 self.move_tower(piece_origin,piece_to_go)
	end
end
class Horse <Piece
	def initialize
		super
		@draw_piece="N"
	end
	def can_move_to(piece_origin,piece_to_go)
		( self.move_horse_circle(piece_origin,piece_to_go) ) && !self.move_tower(piece_origin,piece_to_go)  && !self.move_bishop(piece_origin,piece_to_go)
	end
end
class Bishop <Piece
	def initialize
		super
		@draw_piece="B"
	end
	def can_move_to(piece_origin,piece_to_go)
		 self.move_bishop(piece_origin,piece_to_go)
	end
end
class Queen <Piece
	def initialize
		super
		@draw_piece="Q"
	end
	def can_move_to(piece_origin,piece_to_go)
		self.move_tower(piece_origin,piece_to_go) || self.move_bishop(piece_origin,piece_to_go)
	end
end
class King <Piece
	def initialize
		super
		@draw_piece="K"
	end
	def can_move_to(piece_origin,piece_to_go)
		self.move_king(piece_origin,piece_to_go)
	end
end
class Pown <Piece
	def initialize
		super
		@draw_piece="P"
	end
	def can_move_to(piece_origin,piece_to_go)
		self.move_king(piece_origin,piece_to_go)
	end
end
 INITIALIZE_BOARD = {
 "A1" => Tower.new, 
 "B1" => Horse.new,
 "C1" => Bishop.new, 
 "D1" => Queen.new, 
 "E1" => King.new,
 "F1" => Bishop.new, 
 "G1" => Horse.new, 
 "H1" => Tower.new, 

 "A8" => Tower.new, 
 "B8" => Horse.new, 
 "C8" => Bishop.new, 
 "D8" => Queen.new, 
 "E8" => King.new,
 "F8" => Bishop.new, 
 "G8" => Horse.new, 
 "H8" => Tower.new
}
board=Board.new(INITIALIZE_BOARD)
board.print

binding.pry
#board.print print board instance
#board.piece("B1") search piece in board
#board.move_piece("A1","A2") board move