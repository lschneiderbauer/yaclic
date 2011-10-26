module Yaclic
	
	MATH_METHODS = [:acos,:acosh,:asin,:asinh,:atan,:atanh,:cos,:cosh,:erf,:erfc,:exp,
				:log,:log10,:sin,:sinh,:sqrt,:tan,:tanh]
	SYMBOL_MAP = {:add => :+, :mul => :*, :pow => :**}


class Expression

	# above environment link
	# operation as symlink
	# expression pointer 1 and 2
	def initialize (kernel, op, ep1=nil, ep2=nil)

		@kernel = kernel
		@type = op

		case @type

			when :add,:mul,:pow
				@bin1,@bin2 = align(ep1,ep2)	

			when *([:add_inv,:mul_inv,:nil]+MATH_METHODS)
				@una = align(ep1)

			when :const_pi, :const_e
				# do nothing

			when :num
				raise ArgumentError unless ep1.is_a? Numeric	
				@num = ep1.to_s.to_r	# p.to_r alone would be very ugly in ruby 1.9

			else
				raise "type not known: '#{@type}'"

		end

	end
	
	def ___clone(new_env)
		Expression.new(new_env, @type, 
			*case @type
				when :add,:mul,:pow
					[@bin1.___clone(new_env),@bin2.___clone(new_env)]
				when *([:add_inv,:mul_inv,:nil]+MATH_METHODS)
					[@una.___clone(new_env),nil]
				when :num
					[@num,nil]
				else
					[nil,nil]
			end
		)
	end


	def apply_operator

		case @type

			when :add,:mul,:pow
				@bin1.operation.apply_operator.send(SYMBOL_MAP[@type], @bin2.operation.apply_operator)

			when :add_inv
				-@una.operation.apply_operator

			when :mul_inv
				1.quo @una.operation.apply_operator

			when *MATH_METHODS
				Math.send(@type, @una.operation.apply_operator)	

			when :const_pi
				Math::PI
			when :const_e
				Math::E

			when :num
				@num

			when :nil
				raise CannotCalculateError.new(@una)
	
		end

	end

	def to_s(unfold=false)

		case @type

			when :add,:mul,:pow
				"(".blue.bold + @bin1.to_s(false,unfold) +
				" " + SYMBOL_MAP[@type].to_s.cyan.bold + " " + @bin2.to_s(false,unfold) + ")".blue.bold

			when :add_inv
				"-#{@una.to_s(false,unfold)}".bold

			when :mul_inv
				"1/#{@una.to_s(false,unfold)}".bold

			when *MATH_METHODS
				"#{@type}(".white.bold + @una.to_s(false,unfold) + ")".white.bold

			when :const_pi
				if RUBY_VERSION >= "1.9"
					"\u03C0".cyan.bold
				else #fallback
					"Pi".cyan.bold
				end

			when :const_e
				if RUBY_VERSION >= "1.9"
					"\u212F".cyan.bold
				else #fallback
					"ee".cyan.bold
				end

			when :num
				@num.to_s.bold.green

			when :nil
				"nil".bold.red

		end

	end


	def op_nil?
		(@type == :nil)
	end

	def op_num?
		(@type == :num)
	end

private
	
	def align(*vars)
		# ep's should be ExpressionPointers
		# if nil do nothing
		# if ExpressionPointers, leave it
		# if Numerics, make ExpressionPointers with Numeric-Operator
		#
		ret = []

		vars.each do |var|

			ret <<
			if var.is_a? Numeric
				@kernel.get_ep(nil,:num,var)

	
			elsif var.is_a? ExpressionPointer
				var

			else
				raise ArgumentError

			end
		end

		return *ret
	end

end
end



# some functionality to deal with Rationals
class String

	def to_r
		ar = self.split(".") # maybe it's a float
		
		r = Rational(ar[0].to_i.abs)
		if !ar[1].nil?

			r += Rational(ar[1].to_i, 10**ar[1].length)

		else 	# or maybe it's already rational
			ar = self.split("/")

			if !ar[1].nil?
				r /= ar[1].to_i
			end
		end

		r = -r if self[0,1] == "-" 	# otherwise the - would vanish

		return r
	end

end if RUBY_VERSION < "1.9"

class Fixnum

	def /(other)
		self.quo other.to_s.to_r
	end

end

class Float

	def /(other)
		self.to_s.to_r / other.to_s.to_r
	end

	alias cf to_f

end

class Rational
	
	alias cf to_f

end
