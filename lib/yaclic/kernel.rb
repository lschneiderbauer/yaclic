module Yaclic
# This class forms the calculating 'kernel'.
# Central is the Kernel#evaluate method, where you can pass
# your input (e.g. 'a << b+c') and you get back a string with the
# appropriate response.
class Kernel

	def initialize(history=nil,env=nil)
		@history = (history || History.new)
		@env = (env || Environment.new)

		@index = Index.new	# Index for ExpressionPointer
	end

	def evaluate(str)
		@history.push!(str)

		if str != "history"
			@env.evaluate(str)
		else
			@history
		end
	end



	def get_ep(operation=nil,sym=nil)

		if sym.nil? || !@index.include?(sym)

			# Create ExpressionPointer
			ep = ExpressionPointer.new(self,operation,sym)

		else
			ep = @index[sym]
		end

		return ep
	end


	def destroy_ep(sym)
		@index.delete(sym) unless sym.nil?
	end



	def clone
		Kernel.new(@history.clone, @env.___clone)	
	end

	def history
		@history
	end

end
end
