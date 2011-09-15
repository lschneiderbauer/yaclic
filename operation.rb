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

class OperatorSub < Operation

	def to_s
		"(#{@operand1} - #{@operand2})"
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

class OperatorNum < Operation

	def initialize(p)
		@operand=p
	end

	def to_s
		@operand.to_s.bold.green
	end

	def apply_operator
		@operand
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
