require 'colored'

class Operation

	def initialize(p1,p2=nil)
		@operand1 = p1
		@operand2 = p2
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

	def to_s
		@operand1.to_s.bold.green
	end

	def apply_operator
		@operand1
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
