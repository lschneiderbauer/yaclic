class Operation

	def apply_operator(operand)
		puts "appy_operator-method has to be implemented!"
	end

end

class OperatorAdd < Operation

	def initialize(expr_pointer1,expr_pointer2)
		@operand1 = expr_pointer1
		@operand2 = expr_pointer2
	end

	#def apply_operator(operand)
	#	#operand + @to_add	
	#end

	def to_s
		"(#{@operand1} + #{@operand2})"
	end

end

#class OperatorMul < Operation
#
#	def initialize(operand_name)
#		@to_mul = operand_name
#	end
#
#	def to_s
#		"#{@to_mul} * "
#	end
#
#end

class OperatorNum < Operation

	def initialize(numeric)
		@numeric = numeric
	end

	def to_s
		@numeric.to_s
	end
end
