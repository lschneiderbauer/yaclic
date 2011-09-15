require './debug.rb'

class ExpressionPointer

	def initialize(expression=nil,sym=nil)
		@expression = expression
		@sym = sym
	end

	def <<(other)
		#TODO check for loops etc!

		# little duck typing
		if other.is_a? ExpressionPointer
			@expression = other.expression	

		else other.is_a? Numeric
			@expression = Expression.new(nil,OperatorNum.new(other))

			debug "numeric value recognized"
		end

	end

	def +(other);	ExpressionPointer.new(Expression.new(self,OperatorAdd.new(other)));	end

	def expression
		@expression
	end

	def to_s
		#!@expression.nil? ? @expression.to_s : "#{@sym}"
		
		unless @sym.nil?
			@sym.to_s
		else
			@expression.to_s
		end

	end

end
