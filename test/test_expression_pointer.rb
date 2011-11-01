require 'test/unit'
require 'yaclic'

class ExpressionPointerTest < Test::Unit::TestCase

	def setup
		@kernel = Yaclic::Kernel.new
		@kernel[:a] << 8
		@kernel[:b] << 2
	end

	def test_assignment

		ep = @kernel[:a]
		ep << 0.3

		assert_equal "3/10", ep.to_s

	end


	def test_function
		
		x = @kernel[:x]
		ep = @kernel.get_ep(:f,:pow,x,2)
		
		s = {}
		(-2..2).each do |i|
			s[i] = i**2		
		end
		assert_equal s, ep[x,-2..2].set

	end


	def test_plus
		@kernel[:f] << @kernel[:a]+@kernel[:b]	
		assert_equal 10, @kernel[:f].calculate
	end

	def test_minus
		@kernel[:f] << @kernel[:a]-@kernel[:b]
		assert_equal 6, @kernel[:f].calculate
	end

	def test_mul
		@kernel[:f] << @kernel[:a]*@kernel[:b]
		assert_equal 16, @kernel[:f].calculate
	end

	def test_div
		@kernel[:f] << @kernel[:a]/@kernel[:b]
		assert_equal 4, @kernel[:f].calculate
	end

	def test_pow
		@kernel[:f] << @kernel[:a]**@kernel[:b]
		assert_equal 64, @kernel[:f].calculate
	end

	def test_min_un
		@kernel[:f] << -@kernel[:a]
		assert_equal -8, @kernel[:f].calculate
	end

	def test_plus_un
		@kernel[:f] << +@kernel[:a]
		assert_equal 8, @kernel[:f].calculate
	end


	def test_operation
		assert_equal true, @kernel.get_ep(nil).operation.op_nil?
	end

	def test_sym
		assert_equal :abc, @kernel[:abc].sym
	end


	def test_to_float
		assert_equal 10.0, (@kernel[:a]+@kernel[:b]).to_float
	end


	def test_clone
		kernel2 = Yaclic::Kernel.new
		@kernel[:a].___clone(kernel2)

		assert_equal 8, kernel2[:a].calculate
	end

end
