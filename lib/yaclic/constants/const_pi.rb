class ConstPi < Expression

	def to_s(ignore)
		if RUBY_VERSION >= "1.9"
			"\u03C0".cyan.bold
		else # fallback
			"Pi".cyan.bold
		end
	end

	def apply_operator
		Math::PI
	end

end
