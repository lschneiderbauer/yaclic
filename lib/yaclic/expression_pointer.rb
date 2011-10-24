module Yaclic
class ExpressionPointer

	# think of sym as the identifier of the expression pointer
	# if there is no sym, it cannot be identified.
	#
	def initialize(env,expression,sym)
		@env = env
		@expression = expression
		@sym = sym
	end

	# assignment operator
	def <<(other)

		@expression = 
		if other.is_a? ExpressionPointer
			other.operation

		elsif other.is_a? Numeric
			Expression.new(@env,:num,other)

		elsif other.nil?
			@env.___destroy_ep(@sym)	
			nil
		end

		return self

	end

	# use as function with x-range
	def [](expr_p,range,step=1)
		Dataset.new(self,expr_p,range,step)
	end


	def -@;	@env.___create_ep(Expression.new(@env,:add_inv,self));	end
	def +@;	self;	end

	def +(other);	@env.___create_ep(Expression.new(@env,:add,self,other));	end
	def -(other);	self.+(@env.___create_ep(Expression.new(@env,:add_inv,other)));	end
	def *(other);	@env.___create_ep(Expression.new(@env,:mul,self,other));	end
	def /(other);	self.*(@env.___create_ep(Expression.new(@env,:mul_inv,other)));	end
	def **(other);	@env.___create_ep(Expression.new(@env,:pow,self,other));	end

	# operation-node
	def operation
		@expression || Expression.new(@env,:nil,self)
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
		return @env.___create_ep(Expression.new(@env,:num,other)), self
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
			@env.___create_ep(Expression.new(@env,m,self))
		end
	end
end
end
