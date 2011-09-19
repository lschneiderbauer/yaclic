class Environment

	def initialize(prompt)
		@prompt = prompt
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


	# define calculator commands
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
		system "man yac"

		"Here you are.".cyan
	end

	def version
		"Release 2".cyan
	end

	def test
		"Okay.".cyan
	end

end
