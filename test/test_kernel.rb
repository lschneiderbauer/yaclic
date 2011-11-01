require 'test/unit'
require 'yaclic'

class KernelTest < Test::Unit::TestCase

	def test_clone

		kernel = Yaclic::Kernel.new

		kernel.evaluate("a << e+f")
		kernel.evaluate("e << 3")
		kernel.evaluate("f << 8")

		new_kernel = kernel.clone

		assert_equal "11", new_kernel.evaluate("a.c")

	end

	def test_set

		kernel = Yaclic::Kernel.new

		kernel[:a] << (kernel[:e] + kernel[:f])
		kernel[:e] << 3
		kernel.get_ep(:f) << Rational(1/3)

		assert_equal Rational(10,3), kernel[:a].calculate

	end
	

end
