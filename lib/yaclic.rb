begin
	require 'gnuplot'
rescue LoadError
	$hasnot_gnuplot = true
end

require 'rational' if RUBY_VERSION < "1.9"

require 'yaclic/colored'

require 'yaclic/dataset'
require 'yaclic/history'
require 'yaclic/index'


# Exceptions
require 'yaclic/cannot_calculate_error'
require 'yaclic/symbol_preserved_error'


# Expressions
require 'yaclic/expression'
require 'yaclic/expression_pointer'


# Environment
require 'yaclic/environment'
require 'yaclic/kernel'
