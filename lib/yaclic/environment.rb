module Yaclic
class Environment
	include Math

	def initialize
	
		# list with expression pointers
		@index = Index.new

		# initialize environment variables/constants
		@index[:_pi] = self.___create_ep(Expression.new(self,:const_pi))
		@index[:_ee] = self.___create_ep(Expression.new(self,:const_e))

	end
	
	def evaluate(str)
		unless str.include? "___"
			eval(str,binding)
		else
			raise SymbolPreservedError.new
		end
	end

	def method_missing(sym, *args)

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

			unless @index.include? s
	
				# create new ExpressionPointer
				expr = self.___create_ep(nil,s)
	
			else

				expr = @index[s]

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

	def ___create_ep(operation=nil,sym=nil)
		
		# create Expression Pointer
		ep = ExpressionPointer.new(self,operation,sym)

		# add to index
		@index[sym] = ep unless sym.nil?

		return ep
	end

	def ___destroy_ep(sym)
		@index.delete(sym) unless sym.nil?
	end

	def ___clone
		env = Environment.new

		@index.each do |sym,ep|
			ep.___clone(env)
		end

		return env
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

	def index
		@index
	end

end

# dynamically map Math methods to Environment methods
MATH_METHODS.each do |m|
	Environment.class_eval do
		define_method m do |expr_p|
			self.___create_ep(Expression.new(@env,m,expr_p))
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
