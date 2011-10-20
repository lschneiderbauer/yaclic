module Yaclic
class BinaryOperator < Expression

	def to_s(unfold=false)
		"(".blue.bold +
			@operand1.to_s(false,unfold) +
			" " + ops.cyan.bold + " " +
			@operand2.to_s(false,unfold) +
		")".blue.bold
	end

end
end
