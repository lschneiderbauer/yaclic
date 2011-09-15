class Operator

	def apply_operator(operand)
		puts "appy_operator-method has to be implemented!"
	end

end

class OperatorAdd < Operator

	def initialize(expr_pointer)
		@to_add = expr_pointer
	end

	#def apply_operator(operand)
	#	#operand + @to_add	
	#end

	def to_s
		"#{@to_add} + "
	end

end

class OperatorMul < Operator

	def initialize(operand_name)
		@to_mul = operand_name
	end

	def to_s
		"#{@to_mul} * "
	end

end

class OperatorNum < Operator

	def initialize(numeric)
		@numeric = numeric
	end

	def to_s
		@numeric.to_s
	end
end
