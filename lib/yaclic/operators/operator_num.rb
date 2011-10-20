module Yaclic
class OperatorNum < Expression

	def initialize(p)
		@numeric=p.to_s.to_r	# p.to_r alone would be very ugly in ruby 1.9
	end

	def to_s(unfold=false) # ignore
		@numeric.to_s.bold.green
	end

	def apply_operator
		@numeric
	end
end
end


# some functionality to deal with Rationals
class String

	def to_r
		ar = self.split(".") # maybe it's a float
		
		r = Rational(ar[0].to_i)
		if !ar[1].nil?

			r += Rational(ar[1].to_i, 10**ar[1].length)

		else 	# or maybe it's already rational
			ar = self.split("/")

			if !ar[1].nil?
				r /= ar[1].to_i
			end
		end
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
