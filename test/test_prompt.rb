require 'test/unit'
require 'yac'

class PromptTest < Test::Unit::TestCase

	def setup
		$stdout = File.new("/dev/null","w")
		@prompt = Prompt.new
	end

	def test_test
			
		assert_equal "Okay.".cyan, @prompt.do_cycle("test")

	end

	def test_simple_calc

		@prompt.do_cycle("d << a + b")
		@prompt.do_cycle("a << 3")
		@prompt.do_cycle("b << 4")

		assert_equal 7.to_s.bold.green, @prompt.do_cycle("d.c")
	end

	def test_less_simple_calc
		
		@prompt.do_cycle("f << ((e+g)*17)/(x/2)")
		@prompt.do_cycle("e << 10+19")
		@prompt.do_cycle("g << y*2")
		@prompt.do_cycle("x << g")
		@prompt.do_cycle("y << 2**3")

		assert_equal 95.625.to_s.bold.green , @prompt.do_cycle("f.c")

	end

	def teardown
		$stdout = STDOUT
	end
end
