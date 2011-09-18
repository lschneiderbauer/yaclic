require 'my_debug.rb'


class ExpressionPointer

	def initialize(operation=nil,sym=nil)
		@operation = operation
		@name = ExpressionPointerName.new(sym,self)
	end

	def <<(other)
		#TODO check for loops etc!

		@operation = 
		if other.is_a? ExpressionPointer
			other.operation
		else other.is_a? Numeric
			debug "numeric value recognized"
			OperatorNum.new(other)
		end

		return self
	end

	def -@;	ExpressionPointer.new(OperatorAddInv.new(self));	end
	def +@;	self;	end

	def +(other);	ExpressionPointer.new(OperatorAdd.new(self,other));	end
	def -(other);	self.+(ExpressionPointer.new(OperatorAddInv.new(other)));	end
	def *(other);	ExpressionPointer.new(OperatorMul.new(self,other));	end
	def /(other);	self.*(ExpressionPointer.new(OperatorMulInv.new(other)));	end
	def **(other);	ExpressionPointer.new(OperatorPow.new(self,other));	end

	# operation-node
	def operation
		@operation || OperatorNil.new
	end

	# calculate
	def calculate
		"#{operation.apply_operator}".bold.green
	#rescue CannotCalculateException
	#	operation.to_s
	#	@name.to_s
	end

	def unfold	# unfold all pointers
		# todo
	end

	alias n operation
	alias c calculate
	alias u unfold


	# to deal with numbers
	def coerce(other)
		debug "coerced"
		return ExpressionPointer.new(OperatorNum.new(other)), self
	end

	# - let to_s decide, waht to print, not "<<"-method (done on "<<"-method-side)
	# - normally, the output should be as input (uncalculated)
	# - if the user wants it calculated, then print as much info calculated as possible (and leave the rest), don't just abort!!
	def to_s

		# decide, what should be printed based on the caller method: distinguish directly from prompt and tree-call
		if caller_method(caller(1).first) == "to_s"
			@name.to_s
		else
			if @name.sym.nil? # a<<2;b<<3;a+b should give 5, not a+b
				begin
					self.c
				rescue CannotCalculateException
					operation.to_s
				end
			else
				operation.to_s
			end
		end

	end


	private

	def caller_method(at)
		if /^(.+?):(\d+)(?::in `(.*)')?/ =~ at
			#file = Regexp.last_match[1]
		    	#line = Regexp.last_match[2].to_i
			method = Regexp.last_match[3]
			#[file, line, method]
		end
	end

end


class ExpressionPointerName

	def initialize(sym, expr_p)
		@sym = sym
		@expr_p = expr_p
	end

	def sym; @sym; end

	def to_s
		unless @sym.nil?
			if @expr_p.operation.is_a? OperatorNil
				@sym.to_s.bold.red
			else
				@sym.to_s.bold.green
			end
		else
			@expr_p.operation.to_s
		end
	end

end
