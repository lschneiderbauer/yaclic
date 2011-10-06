# This class forms the calculating 'kernel'.
# Central is the Environment#evaluate method, where you can pass
# your input (e.g. 'a << b+c') and you get back a string with the
# appropriate response.
class Environment
	include Math

	def initialize

		# initialize environment variables/constants
		@history = History.new	

		@pi = ExpressionPointer.new(ConstPi.new)
		@ee = ExpressionPointer.new(ConstE.new)
	end
	
	def evaluate(str)
		@history.push!(str)
		___silent_eval(str)
	end

	def method_missing(sym, *args)

		debug "method_missing for #{sym}"
		if sym.to_s =~ /^.*/	# if method-name is ascii ..

			if ___silent_eval "@#{sym}.nil?"

				# create new variable with ExpressionPointer
				___silent_eval "@#{sym} = ExpressionPointer.new(nil,:#{sym})"

			end

			return ___silent_eval "@#{sym}"
		end

	end


	# (global) calculator operations
	# ====================================
	def sin(expr_p)
		ExpressionPointer.new(OperatorSin.new(expr_p))
	end
	def cos(expr_p)
		ExpressionPointer.new(OperatorCos.new(expr_p))
	end


	# calculator commands
	# ====================================
	def quit
		exit
	end

	def history
		@history
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


	private

	def ___silent_eval(str)
		eval(str,___env)
	end

	def ___env
		return binding
	end

end
