module Yaclic
class CannotCalculateError < Exception

	def initialize(expr_p=nil)
		@expr_p = expr_p
		super
	end

	def expr_p; @expr_p; end

end
end
