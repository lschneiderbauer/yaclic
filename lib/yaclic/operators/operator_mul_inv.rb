class OperatorMulInv < Expression

	def to_s
		"1/#{@operand1}".bold
	end

	def apply_operator
		1.to_f/@operand1.operation.apply_operator
	end

end
