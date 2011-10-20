module Yaclic
class Environment
	include Math

	def initialize
	
		# initialize environment variables/constants
		@_pi = ExpressionPointer.new(ConstPi.new)
		@_ee = ExpressionPointer.new(ConstE.new)
	end
	
	def evaluate(str)
		eval(str,binding)
	end

	def method_missing(sym, *args)

		debug "method_missing for #{sym}"
		if sym.to_s =~ /^.*/	# if method-name is ascii ..

			syms = []

			# only take a >1 character if the string begins with "_"
			if sym.to_s.chars.first == "_"
				syms = [sym]
			else
				syms = sym.to_s.chars.to_a
			end

			# create each ExpressionPointer
			expr = nil
			syms.each do |s|

				if self.evaluate "@#{s}.nil?"
	
					# create new variable with ExpressionPointer
					expr = self.evaluate "@#{s} = ExpressionPointer.new(nil,:#{s})"

				else

					expr = self.evaluate "@#{s}"

				end

			end

			# and concat them with multiplications (or if just one, leave it)
			expr = self.evaluate syms.join("*") if syms.count > 1

			# got another expression_pointer as argument?
			if !args.empty? && (args[0].is_a?(ExpressionPointer) || args[0].is_a?(Numeric))

				# do multiplication and return the result
				return expr*args[0]

			else # otherwise just return the object
				return expr
			end


		end

	end


	# calculator commands
	# ====================================
	def quit
		exit
	end

	def help
		# opens man-page
		system "man yaclic"

		"Here you are.".cyan
	end

	def version
		"Yaclic r3".bold.cyan + ", 2011 Sept 23, on Ruby #{RUBY_VERSION}".cyan
	end

	def test
		"Okay.".cyan
	end

end

# dynamically map Math methods to Environment methods
::MATH_METHODS.each do |m|
	Environment.class_eval do
		define_method m do |expr_p|
			eval "ExpressionPointer.new(Operator#{m.to_s.capitalize}.new(expr_p))"
		end
	end

end

# undefine interfering methods
('a'..'z').each do |c|
	begin
		Environment.class_eval("undef :#{c}")
	rescue NameError
		debug "cannot undefine #{c}"
	end
end
end
