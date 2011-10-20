module Yaclic
class ExpressionPointer

	def initialize(operation=nil,sym=nil)
		@operation = operation
		@sym = sym
	end

	# assignment operator
	def <<(other)
		#TODO check for loops etc!

		@operation = 
		if other.is_a? ExpressionPointer
			other.operation
		elsif other.is_a? Numeric
			debug "numeric value recognized"
			OperatorNum.new(other)
		end

		return self
	end

	# use as function with x-range
	def [](expr_p,range,step=1)
		Dataset.new(self,expr_p,range,step)
	end


	def -@;	ExpressionPointer.new(OperatorAddInv.new(self));	end
	def +@;	self;	end

	def +(other);	ExpressionPointer.new(OperatorAdd.new(self,other));	end
	def -(other);	self.+(ExpressionPointer.new(OperatorAddInv.new(other)));	end
	def *(other);	ExpressionPointer.new(OperatorMul.new(self,other));	end
	def /(other);	self.*(ExpressionPointer.new(OperatorMulInv.new(other)));	end
	def **(other);	ExpressionPointer.new(OperatorPow.new(self,other));	end

	# operation-node
	def operation
		@operation || OperatorNil.new(self)
	end

	# calculate
	def calculate
		"#{operation.apply_operator}".bold.green
	end

	def unfold	# unfold all pointers
		self.to_s(false,true)
	end

	def to_float
		"#{operation.apply_operator.to_f}".bold.green
	end


	alias n operation
	alias c calculate
	alias cf to_float
	alias u unfold


	# to deal with numbers
	def coerce(other)
		debug "coerced"
		return ExpressionPointer.new(OperatorNum.new(other)), self
	end

	# I admit, this code is a piece of shit,
	# but at least it works, and the results are
	# as I want them.
	def to_s(unfold_first=true, unfold_all=false)
	
		if @sym.nil? && unfold_first
			self.c
		else
			raise CannotCalculateError
		end
	
	rescue CannotCalculateError

		unless unfold_all
			if unfold_first
				get_operation_s(false)
			else
				unless @sym.nil?
					get_sym_s
				else
					get_operation_s(false)
				end
			end
		else
			if operation.is_a? OperatorNum and !@sym.nil?
				get_sym_s
			else
				get_operation_s(true)
			end
		end

	end


	private

	def get_operation_s(unfold)
		unless operation.is_a? OperatorNil
			operation.to_s(unfold)
		else
			get_sym_s
		end
	end
	
	def get_sym_s
		if operation.is_a? OperatorNil
			@sym.to_s.bold.red
		else
			@sym.to_s.bold.green
		end
	end

end

::MATH_METHODS.each do |m|
	ExpressionPointer.class_eval do
		define_method m do
			eval "ExpressionPointer.new(Operator#{m.to_s.capitalize}.new(self))"
		end
	end
end
end
