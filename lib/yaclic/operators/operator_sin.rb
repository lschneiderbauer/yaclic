class OperatorSin < Expression

	def to_s(unfold=false) # ignore
		"sin(".white.bold + @operand1.to_s(false,unfold) + ")".white.bold
	end

	def apply_operator
		Math.sin(@operand1.operation.apply_operator)
	end
end
