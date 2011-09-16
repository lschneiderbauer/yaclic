require 'my_debug.rb'


class ExpressionPointer

	def initialize(operation=nil,sym=nil)
		@operation = operation
		@sym = sym
	end

	def <<(other)
		#TODO check for loops etc!

		if other.is_a? ExpressionPointer
			@operation = other.operation

		else other.is_a? Numeric
			@operation = OperatorNum.new(other)
		
			debug "numeric value recognized"
			return other
		end
	end

	def -@;	ExpressionPointer.new(OperatorAddInv.new(self));	end
	def +@;	self;	end

	def +(other);	ExpressionPointer.new(OperatorAdd.new(self,other));	end
	def -(other);	self.+(ExpressionPointer.new(OperatorAddInv.new(other)));	end
	def *(other);	ExpressionPointer.new(OperatorMul.new(self,other));	end
	def /(other);	self.*(ExpressionPointer.new(OperatorMulInv.new(other)));	end

	# operation-node
	def operation
		@operation || OperatorNil.new
	end
	alias n operation

	# calculate
	def calculate
		"#{@operation.apply_operator}".bold.green
	end
	alias c calculate


	# to deal with numbers
	def coerce(other)
		debug "coerced"
		return self,other
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
			begin
				self.c
			rescue CannotCalculateException
				@operation.to_s
			end
		end

	end

end
