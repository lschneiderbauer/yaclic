require 'colored'

class Operation

	def initialize(p1,p2=nil)	

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

class OperatorAdd < Operation

	def to_s
		"(".blue.bold + "#{@operand1} ".bold + "+".cyan.bold + " #{@operand2}".bold + ")".blue.bold
	end

	def apply_operator
		@operand1.operation.apply_operator + @operand2.operation.apply_operator
	end

end

class OperatorMul < Operation

	def to_s
		"(".blue.bold + "#{@operand1} ".bold + "*".cyan.bold + " #{@operand2}".bold + ")".blue.bold
	end

	def apply_operator
		@operand1.operation.apply_operator * @operand2.operation.apply_operator
	end

end

class OperatorPow < Operation

	def to_s
		"(".blue.bold + "#{@operand1} ".bold + "**".cyan.bold + " #{@operand2}".bold + ")".blue.bold
	end

	def apply_operator
		@operand1.operation.apply_operator ** @operand2.operation.apply_operator
	end

end

class OperatorAddInv < Operation

	def to_s
		"-#{@operand1}".bold
	end

	def apply_operator
		-@operand1.operation.apply_operator
	end

end

class OperatorMulInv < Operation

	def to_s
		"1/#{@operand1}".bold
	end

	def apply_operator
		1.to_f/@operand1.operation.apply_operator
	end

end


class OperatorNum < Operation

	def initialize(p)
		@numeric=p
	end

	def to_s
		@numeric.to_s.bold.green
	end

	def apply_operator
		@numeric
	end
end

class OperatorNil < Operation

	def initialize()

	end

	def apply_operator
		raise CannotCalculateException
	end

	def to_s
		"nil".bold.red
	end
end

class CannotCalculateException < Exception; end
