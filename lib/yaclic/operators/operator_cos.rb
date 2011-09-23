class OperatorCos < Expression

	def to_s(unfold=false) # ignore
		"cos(".white.bold + @operand1.to_s(unfold) + ")".white.bold
	end

	def apply_operator
		Math.cos(@operand1.operation.apply_operator)
	end
end
