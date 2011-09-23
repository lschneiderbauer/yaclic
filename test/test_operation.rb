require 'test/unit'
require 'yaclic'

class OperationTest < Test::Unit::TestCase

	def test_add
		o = OperatorAdd.new(10,5)

		assert_equal 15, o.apply_operator
	end

	def test_mul
		o = OperatorMul.new(10,5)
		
		assert_equal 50, o.apply_operator
	end

	def test_pow
		o = OperatorPow.new(10,2)

		assert_equal 100, o.apply_operator
	end

	def test_add_inv
		o = OperatorAdd.new(10,ExpressionPointer.new(OperatorAddInv.new(5)))

		assert_equal 5, o.apply_operator
	end

	def test_mul_inv
		o = OperatorMul.new(10,ExpressionPointer.new(OperatorMulInv.new(5)))

		assert_equal 2, o.apply_operator
	end

	def test_sin
		o = OperatorSin.new(Math::PI/2)

		assert_equal 1.to_f, o.apply_operator
	end
	
end
