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
			return other
		end
	end


	def +(other);	ExpressionPointer.new(OperatorAdd.new(self,other));	end
	def -(other);	ExpressionPointer.new(OperatorSub.new(self,other));	end
	def *(other);	ExpressionPointer.new(OperatorMul.new(self,other));	end
	def /(other);	ExpressionPointer.new(OperatorDiv.new(self,other));	end

	def operation
		@operation || OperatorNil.new
	end
	alias n operation

	def c
		@operation.apply_operator
	end


	def to_s

		unless @sym.nil?
			if @operation.nil? or @operation.is_a? OperatorNil
				@sym.to_s.bold.red
			else
				@sym.to_s.bold.green
			end
		else
			debug "sym is nil"
			@operation.to_s
		end

	end

end
