require 'pry'
module MoveHelper
		def move_tower(pice_origin,pice_to_go)
			  change_to_i(pice_origin,pice_to_go)
			  @origin_vertical_move==@to_go_vertical_move || @origin_hotizontal_move==@to_go_hotizontal_move
		end
		def move_bishop(pice_origin,pice_to_go)
			change_to_i(pice_origin,pice_to_go)
			  (@to_go_vertical_move-@origin_vertical_move).abs==(@to_go_hotizontal_move-@origin_hotizontal_move).abs
		end
		def move_horse_circle(pice_origin,pice_to_go)
			change_to_i(pice_origin,pice_to_go)
			 (@to_go_vertical_move-@origin_vertical_move).abs<=2 && (@to_go_hotizontal_move-@origin_hotizontal_move).abs<=2
		end
end
class Board
	attr_accessor :hash_board, :pice_to_go, :pice_to_go, :pice_in_board
	def initialize(hash_board)
		@hash_board=hash_board
		@b={}
		@hash_board.each do |key,value|
			if @hash_board[key]==nil
				@b[key]="-"
			else
				@b[key]=value.draw_pice
			end
		end
		def print_board
			puts "#{@b["A8"]} #{@b["B8"]} #{@b["C8"]} #{@b["D8"]} #{@b["E8"]} #{@b["F8"]} #{@b["G8"]} #{@b["H8"]}"
			puts "#{@b["A7"]} #{@b["B7"]} #{@b["C7"]} #{@b["D7"]} #{@b["E7"]} #{@b["F7"]} #{@b["G7"]} #{@b["H7"]}"
			puts "#{@b["A6"]} #{@b["B6"]} #{@b["C6"]} #{@b["D6"]} #{@b["E6"]} #{@b["F6"]} #{@b["G6"]} #{@b["H6"]}"
			puts "#{@b["A5"]} #{@b["B5"]} #{@b["C5"]} #{@b["D5"]} #{@b["E5"]} #{@b["F5"]} #{@b["G5"]} #{@b["H5"]}"
			puts "#{@b["A4"]} #{@b["B4"]} #{@b["C4"]} #{@b["D4"]} #{@b["E4"]} #{@b["F4"]} #{@b["G4"]} #{@b["H4"]}"
			puts "#{@b["A3"]} #{@b["B3"]} #{@b["C3"]} #{@b["D3"]} #{@b["E3"]} #{@b["F3"]} #{@b["G3"]} #{@b["H3"]}"
			puts "#{@b["A2"]} #{@b["B2"]} #{@b["C2"]} #{@b["D2"]} #{@b["E2"]} #{@b["F2"]} #{@b["G2"]} #{@b["H2"]}"
			puts "#{@b["A1"]} #{@b["B1"]} #{@b["C1"]} #{@b["D1"]} #{@b["E1"]} #{@b["F1"]} #{@b["G1"]} #{@b["H1"]}"
		end
	  
	end
	def move_pice(pice_origin,pice_to_go)
		pice_in_board=@hash_board[pice_origin]
		pice_in_board.can_move_to(pice_origin,pice_to_go)
	end
	def piece(pice_search)
		pice_in_board=@hash_board[pice_search]
	end
end
class Piece
	attr_accessor :origin, :to_go, :origin_vertical_move ,:origin_hotizontal_move,:to_go_vertical_move, :to_go_hotizontal_move
	attr_accessor :draw_pice
	include MoveHelper
	def change_to_i(pice_origin,pice_to_go)
		@origin_vertical_move=pice_origin[0].downcase.ord-96
		@origin_hotizontal_move=pice_origin[1].to_i 
		@to_go_vertical_move=pice_to_go[0].downcase.ord-96
		@to_go_hotizontal_move=pice_to_go[1].to_i 
	end
end
class Tower <Piece
	def initialize
		@draw_pice="R"
	end
	def can_move_to(pice_origin,pice_to_go)
		 self.move_tower(pice_origin,pice_to_go)
	end
end
class Horse <Piece
	def initialize
		super
		@draw_pice="N"
	end
	def can_move_to(pice_origin,pice_to_go)
		( self.move_horse_circle(pice_origin,pice_to_go) ) && !self.move_tower(pice_origin,pice_to_go)  && !self.move_bishop(pice_origin,pice_to_go)
	end
end
class Bishop <Piece
	def initialize
		super
		@draw_pice="B"
	end
	def can_move_to(pice_origin,pice_to_go)
		 self.move_bishop(pice_origin,pice_to_go)
	end
end
class Queen <Piece
	def initialize
		super
		@draw_pice="Q"
	end
	def can_move_to(pice_origin,pice_to_go)
		self.move_tower(pice_origin,pice_to_go) || self.move_bishop(pice_origin,pice_to_go)
	end
end
class King <Piece
	def initialize
		super
		@draw_pice="K"
	end
	def can_move_to(pice_origin,pice_to_go)
		self.move_tower(pice_origin,pice_to_go)
	end
end
class Pown <Piece
	def initialize
		super
		@draw_pice="P"
	end
	def can_move_to(pice_origin,pice_to_go)
		self.move_tower(pice_origin,pice_to_go)
	end
end
#"f".downcase.ord-96 
 a = {
 "A1" => Tower.new, 
 "B1" => Horse.new,
 "C1" => Bishop.new, 
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
#board.hash_board["B1"]  search pice in board
#board.move_pice("A1","H7") board move