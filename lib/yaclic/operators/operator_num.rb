class OperatorNum < Expression

	def initialize(p)
		@numeric=p
	end

	def to_s(unfold=false) # ignore
		@numeric.to_s.bold.green
	end

	def apply_operator
		@numeric
	end
end
