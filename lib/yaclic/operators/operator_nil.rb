class OperatorNil < Expression

	def initialize()

	end

	def apply_operator
		raise CannotCalculateError
	end

	def to_s
		"nil".bold.red
	end
end
