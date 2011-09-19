require 'test/unit'
require 'yac'

class OperationTest < Test::Unit::TestCase

	def test_add
		o = OperatorAdd.new(10,5)

		assert_equal o.apply_operator, 15
	end

	def test_mul
		o = OperatorMul.new(10,5)
		
		assert_equal o.apply_operator, 50
	end

	def test_pow
		o = OperatorPow.new(10,2)

		assert_equal o.apply_operator, 100
	end
	
end
