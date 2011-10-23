module Yaclic
class SymbolPreservedError < Exception

	def initialize(sym=nil)
		@sym = sym
		super
	end

	def symbol
		@sym
	end

end
end
