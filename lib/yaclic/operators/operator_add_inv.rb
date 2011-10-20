class OperatorAddInv < Expression

	def to_s(unfold=false)
		"-#{@operand1.to_s(false,unfold)}".bold
	end

	def apply_operator
		-@operand1.operation.apply_operator
	end

end
