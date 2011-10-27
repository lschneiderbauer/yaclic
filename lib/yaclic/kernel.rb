module Yaclic
# This class forms the calculating 'kernel'.
# Central is the Kernel#evaluate method, where you can pass
# your input (e.g. 'a << b+c') and you get back a string with the
# appropriate response.
class Kernel

	def initialize(history=nil,env=nil)
		@history = (history || History.new)
		@env = (env || Environment.new(self))

		@index = Index.new	# Index for ExpressionPointer

		# create constants
		self.get_ep(:_pi, :const_pi)
		self.get_ep(:_ee, :const_e)
	end

	def evaluate(str)
		@history.push!(str)

		if str != "history"
			@env.evaluate(str)
		else
			@history
		end
	end


	# Takes care of creating ExpressionPointeres
	# ExpressionPointer should _only_ be created here.
	#
	def get_ep(sym=nil,*operations_params)

		operation = nil
		if (!operations_params.nil? && !operations_params.empty?)	# create the expression then
			operation = Expression.new(self,*operations_params)
		end

		if sym.nil? || !@index.include?(sym)

			# Create ExpressionPointer
			ep = ExpressionPointer.new(self,sym,operation)

			@index[sym] = ep unless sym.nil?
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
