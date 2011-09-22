class OperatorAddInv < Expression

	def to_s
		"-#{@operand1}".bold
	end

	def apply_operator
		-@operand1.operation.apply_operator
	end

end
