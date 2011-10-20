module Yaclic
# This class forms the calculating 'kernel'.
# Central is the Environment#evaluate method, where you can pass
# your input (e.g. 'a << b+c') and you get back a string with the
# appropriate response.
class Kernel

	def initialize(history=nil,env=nil)
		@history = (history || History.new)
		@env = (env || Environment.new)
	end

	def evaluate(str)
		@history.push!(str)

		if str != "history"
			@env.evaluate(preprocess_input(str))
		else
			@history
		end
	end

	def set(sym, value)
		@env.evaluate("#{sym} << #{value}")
	end

	def clone
		Kernel.new(@history.clone, @env.___clone)	
	end

	def history
		@history
	end


	private

	def preprocess_input(str)
	        # add "*" if
		# - paranthesis (must look away from letter) next to letter then
		# - letters separated with whitespace are next to each other
		# - numbers ...
		str
	end

end
end
