require './debug.rb'

class ExpressionPointer

	def initialize(operation=nil,sym=nil)
		@operation = operation
		@sym = sym
	end

	def <<(other)
		#TODO check for loops etc!

		# little duck typing
		if other.is_a? ExpressionPointer
			@operation = other.operation

		else other.is_a? Numeric
			@operation = OperatorNum.new(other)

			debug "numeric value recognized"
		end
	end


	def +(other);	ExpressionPointer.new(OperatorAdd.new(self,other));	end
	def -(other);	ExpressionPointer.new(OperatorSub.new(self,other));	end
	def *(other);	ExpressionPointer.new(OperatorMul.new(self,other));	end
	def /(other);	ExpressionPointer.new(OperatorDiv.new(self,oterh));	end

	def operation
		@operation
	end
	alias n operation


	def to_s

		unless @sym.nil?
			@sym.to_s
		else
			@operation.to_s
		end

	end

end
