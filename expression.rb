require 'operator'

class Expression

	def initialize(expr_pointer, operation)
		@operand = expr_pointer
		@operation = operation
	end

	#def evaluate
	#	# todo: do a real calculation or if not possible run a 'simplifier'
	#end

	def to_s
		s = "("
		s << "#{@operation}"
		s << "#{@operand}"
		s << ")"
		return s
	end

end
