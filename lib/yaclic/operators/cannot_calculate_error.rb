class CannotCalculateError < Exception

	def initialize(expr_p=nil)
		@expr_p = expr_p
	end

	def expr_p; @expr_p; end

end
