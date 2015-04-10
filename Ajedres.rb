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
	def initialize(origin)
		@origin
	end
	def can_move_to(to_go)
		@origin_vertical_move[0]=@origin[0]
		@origin_vertical_move[1]=@origin[1]
		@to_go_vertical_move[0]=@origin[0]
		@to_go_hotizontal_move[1]=@origin[1]
		return true if @origin_vertical_move==to_go_vertical_move
		return true if @origin_hotizontal_move==to_go_hotizontal_move
	end
end