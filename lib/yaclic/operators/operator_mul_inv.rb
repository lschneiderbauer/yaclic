class OperatorMulInv < Expression

	def to_s(unfold=false)
		"1/#{@operand1.to_s(unfold)}".bold
	end

	def apply_operator
		1.quo @operand1.operation.apply_operator
		#1.to_f/@operand1.operation.apply_operator
	end

end
