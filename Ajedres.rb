require 'pry'
a = {
 "A1" => Tower.new("A1"), 
 "B1" => Horse.new("B1"),
 "C1" => Bishop.new("C1"), 
 "D1" => Queen.new("D1"), 
 "E1" => King.new("E1"),
 "F1" => Bishop.new("F1"), 
 "G1" => Horse.new("G1"), 
 "H1" => Tower.new("H1"), 

 "A8" => Tower.new("A8"), 
 "B8" => Horse.new("B8"), 
 "C8" => Bishop.new("C8"), 
 "D8" => Queen.new("D8"), 
 "E8" => King.new("E8"),
 "F8" => Bishop.new("F8"), 
 "G8" => Horse.new("G8"), 
 "H8" => Tower.new("H8")
}
module MoveHelper
		def move_tower(to_go)
			change_to_i(to_go)
			  @origin_vertical_move==@to_go_vertical_move || @origin_hotizontal_move==@to_go_hotizontal_move
		end
		def move_bishop(to_go)
			change_to_i(to_go)
			  (@to_go_vertical_move-@origin_vertical_move).abs==(@to_go_hotizontal_move-@origin_hotizontal_move).abs
		end
		def move_horse_circle(to_go)
			change_to_i(to_go)
			 (@to_go_vertical_move-@origin_vertical_move).abs<=2 && (@to_go_hotizontal_move-@origin_hotizontal_move).abs<=2
		end
end
class Board
	attr_accessor :hash_board
	def initialize
		@hash_board=a
	end
	def print_board(){
	  puts "#{@hash_board["A8"]} #{@hash_board["B8"]} #{@hash_board["C8"]} #{@hash_board["D8"]} #{@hash_board["E8"]} #{@hash_board["F8"]} #{@hash_board["G8"]} #{@hash_board["H8"]}"
	  puts "#{@hash_board["A7"]} #{@hash_board["B7"]} #{@hash_board["C7"]} #{@hash_board["D7"]} #{@hash_board["E7"]} #{@hash_board["F7"]} #{@hash_board["G7"]} #{@hash_board["H7"]}"
	  puts "#{@hash_board["A8"]} #{@hash_board["B8"]} #{@hash_board["C8"]} #{@hash_board["D8"]} #{@hash_board["E8"]} #{@hash_board["F8"]} #{@hash_board["G8"]} #{@hash_board["H8"]}"
	  puts "#{@hash_board["A3"]} #{@hash_board["B3"]} #{@hash_board["C3"]} #{@hash_board["D3"]} #{@hash_board["E3"]} #{@hash_board["F3"]} #{@hash_board["G3"]} #{@hash_board["H3"]}"
	  puts "#{@hash_board["A2"]} #{@hash_board["B2"]} #{@hash_board["C2"]} #{@hash_board["D2"]} #{@hash_board["E2"]} #{@hash_board["F2"]} #{@hash_board["G2"]} #{@hash_board["H2"]}"
	  puts "#{@hash_board["A1"]} #{@hash_board["B1"]} #{@hash_board["C1"]} #{@hash_board["D1"]} #{@hash_board["E1"]} #{@hash_board["F1"]} #{@hash_board["G1"]} #{@hash_board["H1"]}"
	  

		
	end
	def tranform_hash
		b={}
		a.each do |key,value|
			if a[key]==nil
				b[key]="-"
			else
				b[key]=value.draw_pice
			end
		end
		}
	end
end
class Piece
	attr_accessor :origin, :to_go, :origin_vertical_move ,:origin_hotizontal_move,:to_go_vertical_move, :to_go_hotizontal_move
	attr_accessor :draw_pice
	include MoveHelper
	def initialize(origin)
		@origin_vertical_move=origin[0].downcase.ord-96
		@origin_hotizontal_move=origin[1].to_i 
	end
	def change_to_i(to_go)
		@to_go_vertical_move=to_go[0].downcase.ord-96
		@to_go_hotizontal_move=to_go[1].to_i 
	end
end
class Tower <Piece
	def initialize(origin)
		super
		@draw_pice="R"
	end
	def can_move_to(to_go)
		 self.move_tower(to_go)
	end
end
class Horse <Piece
	def initialize(origin)
		super
		@draw_pice="N"
	end
	def can_move_to(to_go)
		( self.move_horse_circle(to_go) ) && !self.move_tower(to_go)  && !self.move_bishop(to_go)
	end
end
class Bishop <Piece
	def initialize(origin)
		super
		@draw_pice="B"
	end
	def can_move_to(to_go)
		 self.move_bishop(to_go)
	end
end
class Queen <Piece
	def initialize(origin)
		super
		@draw_pice="Q"
	end
	def can_move_to(to_go)
		self.move_tower(to_go) || self.move_bishop(to_go)
	end
end
class King <Piece
	def initialize(origin)
		super
		@draw_pice="K"
	end
	def can_move_to(to_go)
		self.move_tower(to_go)
	end
end
class Pown <Piece
	def initialize(origin)
		super
		@draw_pice="P"
	end
	def can_move_to(to_go)
		self.move_tower(to_go)
	end
end
torre=Tower.new("D2") 
arfil=Bishop.new("D2") 
reina=Queen.new("D2") 
horse=Horse.new("D2") 
rey=King.new("D2") 
peon=Pown.new("D2") 
puts torre.can_move_to("D8") 
puts arfil.can_move_to("D8") 
puts reina.can_move_to("D8") 
puts horse.can_move_to("D8") 
#"f".downcase.ord-96 
 
b={}
a.each do |key,value|
	if a[key]==nil
		b[key]="-"
	else
		b[key]=value.draw_pice
	end
end
binding.pry
puts ""