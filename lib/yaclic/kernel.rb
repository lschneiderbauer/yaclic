module Yaclic
# This class forms the calculating 'kernel'.
# Central is the Kernel#evaluate method, where you can pass
# your input (e.g. 'a << b+c') and you get back a string with the
# appropriate response.
class Kernel

	def initialize(history=nil)
		@history = (history || History.new)
		@env = Environment.new(self)
		@index = Index.new	# Index for ExpressionPointer

		@debug = false	# general debug variable

		# create constants
		self.get_ep(:_pi, :const_pi)
		self.get_ep(:_ee, :const_e)
	end

	def evaluate(str)
		@history.push!(str)

		@env.evaluate(str)
	end


	# Takes care of creating ExpressionPointeres
	# ExpressionPointer should _only_ be created here.
	# Exception: Cloning-part
	def get_ep(sym=nil,*operations_params)

		operation = nil
		if (!operations_params.nil? &&
			!operations_params.empty? &&
				!operations_params[0].nil? &&
					!operations_params[0].is_a?(Expression))

			# create the expression then
			operation = Expression.new(self,*operations_params)
			
		elsif operations_params[0].is_a? Expression

			operation = operations_params[0]
		end

		if (sym.nil? || !@index.include?(sym))

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
		new_kernel = Kernel.new(@history.clone)

		@index.each do |sym,ep|
			ep.___clone(new_kernel)
		end

		return new_kernel
	end


	def [](sym)
		self.get_ep(sym)
	end

	def index
		@index.clone
	end

	def history
		@history
	end

	def debug
		@debug
	end

	def debug=(bool)
		@debug = bool
	end

end
end
