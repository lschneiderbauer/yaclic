module Yaclic
class OperatorMul < BinaryOperator

	def ops
		"*"
	end

	def apply_operator
		@operand1.operation.apply_operator * @operand2.operation.apply_operator
	end

end
end
