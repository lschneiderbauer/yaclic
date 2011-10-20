module Yaclic
class Expression

	def initialize(p1=nil,p2=nil)

		@operand1 = 
		if p1.is_a? Numeric then
			debug "conversion from numeric into OperatorNum"
			ExpressionPointer.new(OperatorNum.new(p1))	
		else
			p1
		end

		@operand2 = 
		if p2.is_a? Numeric then
			debug "conversion from numeric into OperatorNum"
			ExpressionPointer.new(OperatorNum.new(p2))
		else
			p2
		end

	end

	def apply_operator
		raise "appy_operator-method has to be implemented!"
	end


	def o1; @operand1; end
	def o2; @operand2; end

end
end
