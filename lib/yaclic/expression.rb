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
				@bin1 = ep1.to_ep(@kernel)
				@bin2 = ep2.to_ep(@kernel)

			when *([:add_inv,:mul_inv,:nil]+MATH_METHODS)
				@una = ep1.to_ep(@kernel)

			when :const_pi, :const_e
				# do nothing

			when :num
				raise ArgumentError unless ep1.is_a? Rational
				@num = ep1

			else
				raise "type not known: '#{@type}'"

		end

	end
	
	def ___clone(new_kernel)
		return Expression.new(new_kernel, @type, 
			*case @type
				when :add,:mul,:pow
					[@bin1.___clone(new_kernel),@bin2.___clone(new_kernel)]
				when *([:add_inv,:mul_inv,:nil]+MATH_METHODS)
					[@una.___clone(new_kernel),nil]
				when :num
					[@num,nil]
				else # including :const_pi, :const_e
					[nil,nil]
			end
		) unless @type == :nil

		# else return nil
		return nil
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

class Numeric

	def to_ep(kernel)
		rat = self.to_r
		return kernel.get_ep(nil,:num,rat)
	end

end

class Fixnum

	def /(other)
		self.quo other.to_r
	end

end

class Float

	def /(other)
		self.to_r / other.to_r	
	end

	# Float cannot be converted to Rational (in general)
	#
	def to_r
		return self
	end

	alias cf to_f

end

class Rational

	alias cf to_f

	# automatically split powers of 10
	#
	alias orig_to_s to_s
	def to_s

		if (self == 0)
			return orig_to_s
		end

		power_p = 0
		power_n = 0
		while ((self.numerator % (10**(power_p+1))) == 0) do power_p += 1 end
		while ((self.denominator % (10**(power_n+1))) == 0) do power_n += 1 end

		power = power_p - power_n

		if power < 3 && power > -3	# activate enhanced output on which power?
			return orig_to_s
		else
			new_rat = (self*(10**-power))

			if new_rat == 1
				return "10x#{power}"
			else
				return new_rat.orig_to_s + " 10x#{power}"
			end
		end

	end

end
