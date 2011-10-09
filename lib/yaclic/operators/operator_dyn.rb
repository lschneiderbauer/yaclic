# Map Math-functions to Operator-classes

::MATH_METHODS.each do |m|

	# create new class
	o = eval "Operator#{m.to_s.capitalize} = Class.new(Expression)"
	
	# create its methods
	o.class_eval do
		define_method :to_s do |unfold|
			unfold ||= false

			"#{m}(".white.bold + @operand1.to_s(false,unfold) + ")".white.bold
		end

		define_method :apply_operator do
			Math.send(m, @operand1.operation.apply_operator)
		end
	end

end
