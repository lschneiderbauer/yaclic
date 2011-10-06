begin
	require 'gnuplot'
rescue LoadError
	$hasnot_gnuplot = true
end


require 'yaclic/my_debug'
require 'yaclic/colored'
require 'yaclic/dataset'
require 'yaclic/history'

# Expressions
require 'yaclic/expression_pointer'
require 'yaclic/expression'

# Operators
require 'yaclic/operators/cannot_calculate_error'
require 'yaclic/operators/operator_num'
require 'yaclic/operators/operator_nil'
require 'yaclic/operators/binary_operator'
require 'yaclic/operators/operator_add'
require 'yaclic/operators/operator_mul'
require 'yaclic/operators/operator_pow'
require 'yaclic/operators/operator_sin'
require 'yaclic/operators/operator_cos'
require 'yaclic/operators/operator_add_inv'
require 'yaclic/operators/operator_mul_inv'

# Constants
require 'yaclic/constants/const_pi'
require 'yaclic/constants/const_e'

require 'yaclic/environment'
