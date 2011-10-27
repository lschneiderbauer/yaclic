require 'test/unit'
require 'yaclic'

class OperationTest < Test::Unit::TestCase
	include Yaclic

	def setup
		@kernel = Yaclic::Kernel.new
	end

	def test_add
		o = Expression.new(@kernel,:add,10,5)

		assert_equal 15, o.apply_operator
	end

	def test_mul
		o = Expression.new(@kernel,:mul,10,5)
		
		assert_equal 50, o.apply_operator
	end

	def test_pow
		o = Expression.new(@kernel,:pow,10,2)

		assert_equal 100, o.apply_operator
	end

	def test_add_inv
		@kernel.get_ep(:o,:add,10,@kernel.get_ep(nil,:add_inv,5))

		assert_equal 5, @kernel[:o].calculate
	end

	def test_mul_inv
		@kernel.get_ep(:o,:mul,10,@kernel.get_ep(nil,:mul_inv,5))

		assert_equal 2, @kernel[:o].calculate
	end

	def test_sin
		o = Expression.new(@kernel,:sin,Math::PI/2)

		assert_equal 1.to_f, o.apply_operator
	end
	
end
