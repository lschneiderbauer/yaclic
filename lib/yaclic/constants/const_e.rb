class ConstE < Expression
	
	def to_s(ignore)
		if RUBY_VERSION >= "1.9"
			"\u212F".cyan.bold
		else #fallback
			"ee".cyan.bold
		end
	end

	def apply_operator
		Math::E
	end

end
