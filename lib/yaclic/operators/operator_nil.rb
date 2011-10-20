module Yaclic
class OperatorNil < Expression

	def initialize(expr_p)
		@expression_pointer = expr_p
	end

	def apply_operator
		raise CannotCalculateError.new(@expression_pointer)
	end

	def to_s
		"nil".bold.red
	end
end
end
