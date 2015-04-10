require 'pry'
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
end
class Board
	attr_accessor :hash_board, :piece_to_go, :piece_to_go, :piece_in_board
	def initialize(hash_board)
		@hash_board=hash_board
		@board_to_print={}
		@hash_board.each do |key,value|
			if @hash_board[key]==nil
				@board_to_print[key]="-"
			else
				@board_to_print[key]=value.draw_piece
			end
		end
		def print
			puts "#{@board_to_print["A8"]} #{@board_to_print["B8"]} #{@board_to_print["C8"]} #{@board_to_print["D8"]} #{@board_to_print["E8"]} #{@board_to_print["F8"]} #{@board_to_print["G8"]} #{@board_to_print["H8"]}"
			puts "#{@board_to_print["A7"]} #{@board_to_print["B7"]} #{@board_to_print["C7"]} #{@board_to_print["D7"]} #{@board_to_print["E7"]} #{@board_to_print["F7"]} #{@board_to_print["G7"]} #{@board_to_print["H7"]}"
			puts "#{@board_to_print["A6"]} #{@board_to_print["B6"]} #{@board_to_print["C6"]} #{@board_to_print["D6"]} #{@board_to_print["E6"]} #{@board_to_print["F6"]} #{@board_to_print["G6"]} #{@board_to_print["H6"]}"
			puts "#{@board_to_print["A5"]} #{@board_to_print["B5"]} #{@board_to_print["C5"]} #{@board_to_print["D5"]} #{@board_to_print["E5"]} #{@board_to_print["F5"]} #{@board_to_print["G5"]} #{@board_to_print["H5"]}"
			puts "#{@board_to_print["A4"]} #{@board_to_print["B4"]} #{@board_to_print["C4"]} #{@board_to_print["D4"]} #{@board_to_print["E4"]} #{@board_to_print["F4"]} #{@board_to_print["G4"]} #{@board_to_print["H4"]}"
			puts "#{@board_to_print["A3"]} #{@board_to_print["B3"]} #{@board_to_print["C3"]} #{@board_to_print["D3"]} #{@board_to_print["E3"]} #{@board_to_print["F3"]} #{@board_to_print["G3"]} #{@board_to_print["H3"]}"
			puts "#{@board_to_print["A2"]} #{@board_to_print["B2"]} #{@board_to_print["C2"]} #{@board_to_print["D2"]} #{@board_to_print["E2"]} #{@board_to_print["F2"]} #{@board_to_print["G2"]} #{@board_to_print["H2"]}"
			puts "#{@board_to_print["A1"]} #{@board_to_print["B1"]} #{@board_to_print["C1"]} #{@board_to_print["D1"]} #{@board_to_print["E1"]} #{@board_to_print["F1"]} #{@board_to_print["G1"]} #{@board_to_print["H1"]}"
		end
	end
	def move_piece(piece_origin,piece_to_go)
		piece_in_board=@hash_board[piece_origin]
		piece_in_board.can_move_to(piece_origin,piece_to_go)
	end
	def piece(piece_search)
		piece_in_board=@hash_board[piece_search]
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
		self.move_tower(piece_origin,piece_to_go)
	end
end
class Pown <Piece
	def initialize
		super
		@draw_piece="P"
	end
	def can_move_to(piece_origin,piece_to_go)
		self.move_tower(piece_origin,piece_to_go)
	end
end
#"f".downcase.ord-96 
 INITIALIZE_BOARD = {
 "A1" => Tower.new, 
 "B1" => Horse.new,
 "C1" => Bishop.new 
 "D1" => Queen.new, 
 "E1" => King.new,
 "F1" => Bishop.new, 
 "G1" => Horse.new, 
 "H1" => Tower.new, 
 
 "A2" => nil, 
 "B2" => nil,
 "C2" => nil, 
 "D2" => nil, 
 "E2" => nil,
 "F2" => nil, 
 "G2" => nil, 
 "H2" => nil,
  
 "A3" => nil, 
 "B3" => nil,
 "C3" => nil, 
 "D3" => nil, 
 "E3" => nil,
 "F3" => nil, 
 "G3" => nil, 
 "H3" => nil,

 "A4" => nil, 
 "B4" => nil,
 "C4" => nil, 
 "D4" => nil, 
 "E4" => nil,
 "F4" => nil, 
 "G4" => nil, 
 "H4" => nil,

 "A5" => nil, 
 "B5" => nil,
 "C5" => nil, 
 "D5" => nil, 
 "E5" => nil,
 "F5" => nil, 
 "G5" => nil, 
 "H5" => nil,

 "A6" => nil, 
 "B6" => nil,
 "C6" => nil, 
 "D6" => nil, 
 "E6" => nil,
 "F6" => nil, 
 "G6" => nil, 
 "H6" => nil,

 "A7" => nil, 
 "B7" => nil,
 "C7" => nil, 
 "D7" => nil, 
 "E7" => nil,
 "F7" => nil, 
 "G7" => nil, 
 "H7" => nil,

 "A8" => Tower.new, 
 "B8" => Horse.new, 
 "C8" => Bishop.new, 
 "D8" => Queen.new, 
 "E8" => King.new,
 "F8" => Bishop.new, 
 "G8" => Horse.new, 
 "H8" => Tower.new
}
board=Board.new(a)
binding.pry
#board.hash_board["B1"]  search piece in board
#board.move_piece("A1","H7") board move