require 'test/unit'
require 'yaclic'

class OperationTest < Test::Unit::TestCase
	include Yaclic

	def setup
		@env = Environment.new
	end

	def test_add
		o = Expression.new(@env,:add,10,5)

		assert_equal 15, o.apply_operator
	end

	def test_mul
		o = Expression.new(@env,:mul,10,5)
		
		assert_equal 50, o.apply_operator
	end

	def test_pow
		o = Expression.new(@env,:pow,10,2)

		assert_equal 100, o.apply_operator
	end

	def test_add_inv
		o = Expression.new(@env,:add,10,ExpressionPointer.new(@env,Expression.new(@env,:add_inv,5),nil))

		assert_equal 5, o.apply_operator
	end

	def test_mul_inv
		o = Expression.new(@env,:mul,10,ExpressionPointer.new(@env,Expression.new(@env,:mul_inv,5),nil))

		assert_equal 2, o.apply_operator
	end

	def test_sin
		o = Expression.new(@env,:sin,Math::PI/2)

		assert_equal 1.to_f, o.apply_operator
	end
	
end
