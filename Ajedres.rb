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
class ValidatorTorre
	attr_accessor :origin
	attr_accessor :to_go
	def initialize(origin)
		@origin=origin
	end
	def can_move_to(to_go)
		@to_go=to_go
		@origin_vertical_move=@origin[0]
		@to_go_vertical_move=@to_go[0]
		@origin_hotizontal_move=@origin[1]
		@to_go_hotizontal_move=@to_go[1]
		return true if @origin_vertical_move==@to_go_vertical_move
		return true if @origin_hotizontal_move==@to_go_hotizontal_move
	end
end

torre=ValidatorTorre.new("D2") 
torre.can_move_to("D8") 