require 'pry'
class Player
	def move_to(origin,to_go)
		return true
		return false
	end
end
class ValidatorTable
	def out_table
	end
end
class ValidatorFicha
	attr_accessor :origin, :to_go
	attr_accessor :origin_vertical_move ,:origin_hotizontal_move
	attr_accessor :to_go_vertical_move, :to_go_hotizontal_move
	def initialize(origin)
		@origin_vertical_move=origin[0].downcase.ord-96
		@origin_hotizontal_move=origin[1].to_i 
	end
end
class ValidatorTorre <ValidatorFicha
	def can_move_to(to_go)
		@to_go_vertical_move=to_go[0].downcase.ord-96
		@to_go_hotizontal_move=to_go[1].to_i 
		return true if @origin_vertical_move==@to_go_vertical_move || @origin_hotizontal_move==@to_go_hotizontal_move
		return false
	end
end
class ValidatorArfil <ValidatorFicha
	def can_move_to(to_go)
		@to_go_vertical_move=to_go[0].downcase.ord-96
		@to_go_hotizontal_move=to_go[1].to_i
		return  @to_go_vertical_move-@origin_vertical_move==@to_go_hotizontal_move-@origin_hotizontal_move
	end
end
class ValidatorReina <ValidatorFicha
	def can_move_to(to_go)
		@to_go_vertical_move=to_go[0].downcase.ord-96
		@to_go_hotizontal_move=to_go[1].to_i 
		return true if @origin_vertical_move==@to_go_vertical_move || @origin_hotizontal_move==@to_go_hotizontal_move
		return true if @to_go_vertical_move-@origin_vertical_move==@to_go_hotizontal_move-@origin_hotizontal_move
		return false
	end
end
torre=ValidatorTorre.new("D2") 
arfil=ValidatorArfil.new("D2") 
reina=ValidatorReina.new("D2") 
torre.can_move_to("D8") 
arfil.can_move_to("D8") 
reina.can_move_to("D8") 
binding.pry
puts ""
#"f".downcase.ord-96 