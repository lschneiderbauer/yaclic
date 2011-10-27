module Yaclic
class ExpressionPointer

	# think of sym as the identifier of the expression pointer
	# if there is no sym, it cannot be identified.
	#
	def initialize(kernel,sym,expression)
		@kernel = kernel
		@expression = expression
		@sym = sym
	end

	# clone into new environment
	#
	def ___clone(new_kernel)

		# create new expression?
		raise "todo"
		#new_kernel.get_ep( @sym, 
		#new_env.___get_ep( (@expression.nil? ? nil : @expression.___clone(new_env)), @sym )

	end

	# assignment operator
	#
	def <<(other)

		@expression = 
		if other.is_a? ExpressionPointer
			other.operation

		elsif other.is_a? Numeric
			Expression.new(@kernel,:num,other)

		elsif other.nil?
			@kernel.destroy_ep(@sym)
			nil
		end

		return self

	end

	# use as function with x-range
	def [](ep,range,step=1)
		Dataset.new(@env,@sym,ep.sym,range,step)
	end


	def -@;	@env.___get_ep(Expression.new(@env,:add_inv,self));	end
	def +@;	self;	end

	def +(other);	@kernel.get_ep(nil,:add,self,other);	end
	def -(other);	self.+(@kernel.get_ep(nil,:add_inv,other));	end
	def *(other);	@kernel.get_ep(nil,:mul,self,other);	end
	def /(other);	self.*(@kernel.get_ep(nil,:mul_inv,other));	end
	def **(other);	@kernel.get_ep(nil,:pow,self,other);	end

	# operation-node
	#
	def operation
		@expression || Expression.new(@kernel,:nil,self)
	end

	def sym
		@sym
	end


	# numeric version
	#
	def calculate
		operation.apply_operator
	end

	def to_float
		operation.apply_operator.to_f
	end

	# string version
	#
	def c
		"#{calculate}".bold.green
	end

	def cf
		"#{to_float}".bold.green
	end

	def unfold	# unfold all pointers
		self.to_s(false,true)
	end
	alias u unfold


	# to deal with numbers
	def coerce(other)
		return @kernel.get_ep(nil,:num,other), self
	end

	# I admit, this code is a piece of shit,
	# but at least it works, and the results are
	# as I want them.
	#
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
			if operation.op_num? and !@sym.nil?
				get_sym_s
			else
				get_operation_s(true)
			end
		end

	end


	private

	def get_operation_s(unfold)
		unless operation.op_nil?
			operation.to_s(unfold)
		else
			get_sym_s
		end
	end
	
	def get_sym_s
		if operation.op_nil?
			@sym.to_s.bold.red
		else
			@sym.to_s.bold.green
		end
	end

end

MATH_METHODS.each do |m|
	ExpressionPointer.class_eval do
		define_method m do	
			@kernel.get_ep(nil,m,self)
		end
	end
end
end
