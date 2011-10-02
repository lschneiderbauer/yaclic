class ExpressionPointer

	def initialize(operation=nil,sym=nil)
		@operation = operation
		@sym = sym
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

	def sin;	ExpressionPointer.new(OperatorSin.new(self));	end
	def cos;	ExpressionPointer.new(OperatorCos.new(self));	end

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
		self.to_s(false,true)
	end

#	def plot(x,range=-1..1)
#		unless $hasnot_gnuplot
#
#			# plot some stuff
#			Gnuplot.open do |gp|
#				Gnuplot::Plot.new gp do |plot|
#
#					plot.title "blah"
#					plot.xrange "[#{range.begin}:#{range.end}]"
#
#					plot.ylabel x.to_s(false,false)
#					plot.xlabel self.to_s(true,true)
#
#					plot.data << Gnuplot::DataSet.new() do
#
#					end
#
#				end
#			end
#
#			"Here you are.".cyan
#		else
#			"gnuplot support not available".red
#		end
#	end


	alias n operation
	alias c calculate
	alias u unfold
#	alias p plot


	# to deal with numbers
	def coerce(other)
		debug "coerced"
		return ExpressionPointer.new(OperatorNum.new(other)), self
	end

	# I admit, this code is a piece of shit,
	# but at least it works, and the results are
	# as I want them.
	def to_s(unfold_first=true, unfold_all=false)
	
		if @sym.nil? && unfold_first
			self.c
		else
			raise CannotCalculateError
		end
	
	rescue CannotCalculateError

		unless unfold_all
			if unfold_first
				get_operation_s(false)
			else
				unless @sym.nil?
					get_sym_s
				else
					get_operation_s(false)
				end
			end
		else
			get_operation_s(true)
		end

	end


	private

	def get_operation_s(unfold)
		unless operation.is_a? OperatorNil
			operation.to_s(unfold)
		else
			get_sym_s
		end
	end
	
	def get_sym_s
		if operation.is_a? OperatorNil
			@sym.to_s.bold.red
		else
			@sym.to_s.bold.green
		end
	end

end
