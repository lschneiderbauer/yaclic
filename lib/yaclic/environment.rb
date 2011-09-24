class Environment
	include Math

	def initialize(prompt)
		@prompt = prompt

		# initialize environment variables/constants
		@pi = ExpressionPointer.new(ConstPi.new)
		@ee = ExpressionPointer.new(ConstE.new)
	end
	
	def env
		return binding
	end

	def method_missing(sym, *args)

		debug "method_missing for #{sym}"
		if sym.to_s =~ /^.*/	# if method-name is ascii ..
			if eval("@#{sym}.nil?",self.env)

				# create new variable with ExpressionPointer
				eval("@#{sym} = ExpressionPointer.new(nil,:#{sym})",self.env)

				debug("new expression pointer initialized: #{eval("@#{sym}")}",1)	
			else
				debug("expression pointer in use",1)
			end
			return eval("@#{sym}",self.env)
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
		"#{@prompt.history.inspect}".cyan
	end

	def help
		# opens man-page
		#`man yac`
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
