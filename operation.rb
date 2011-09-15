class Operation

	def initialize(p1,p2=nil)
		@operand1 = p1
		@operand2 = p2
	end

	def apply_operator(operand)
		puts "appy_operator-method has to be implemented!"
	end

end

class OperatorAdd < Operation

	def to_s
		"(#{@operand1} + #{@operand2})"
	end

end

class OperatorSub < Operation

	def to_s
		"(#{@operand1} - #{@operand2})"
	end

end

class OperatorMul < Operation

	def to_s
		"#{@operand1} * #{@operand2}"
	end

end

class OperatorNum < Operation

	def to_s
		@operand1.to_s
	end
end
