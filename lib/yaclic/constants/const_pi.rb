class ConstPi < Expression

	def to_s(ignore)
		if RUBY_VERSION.split(".").join.to_i >= 190
			"\u20AC".cyan.bold
		else
			# fallback
			"Pi".cyan.bold
		end
	end

	def apply_operator
		Math::PI
	end

end
