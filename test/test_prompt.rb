require 'test/unit'
require 'yaclic'
require 'yaclic/prompt'

class PromptTest < Test::Unit::TestCase

	def setup
		$stdout = File.new("/dev/null","w")
		
		@prompt = Prompt.new(Yaclic::Kernel.new)
	end

	def teardown
		$stdout = STDOUT
	end


	def test_test
		assert_equal "Okay.", @prompt.do_cycle("test")
	end

	def test_simple_calc
		@prompt.do_cycle("d << a + b")
		@prompt.do_cycle("a << 3")
		@prompt.do_cycle("b << 4")

		assert_equal 7.to_s, @prompt.do_cycle("d.c")
	end

	def test_less_simple_calc
		
		@prompt.do_cycle("f << ((e+g)*17)/(x/2)")
		@prompt.do_cycle("e << 10+19")
		@prompt.do_cycle("g << y*2")
		@prompt.do_cycle("x << g")
		@prompt.do_cycle("y << 2**3")

		assert_equal 95.625.to_s , @prompt.do_cycle("f.cf")

	end

	def test_1	# a<<3;b<<5;a+b should give 8, not "a+b"
		@prompt.do_cycle("x << 3")
		@prompt.do_cycle("y << 4")

		assert_equal 12.to_s,  @prompt.do_cycle("x*y")
	end

	def test_2	# test unfold-function (nil must not be in it)
		@prompt.do_cycle("d << a+b")
		@prompt.do_cycle("a << e+f")
		@prompt.do_cycle("b << 4")

		assert(!(@prompt.do_cycle("d.u").include?("nil")))
	end

	# test more unfold-stuff
	def prep
		@prompt.do_cycle("a << b + c")
		@prompt.do_cycle("b << 3")
	end

	def test_3
		prep
		assert_equal "(b + c)", @prompt.do_cycle("a.to_s")
	end

	def test_4
		prep
		assert_equal "(b + c)", @prompt.do_cycle("a.to_s(true,true)")
	end

	def test_5
		prep
		assert_equal "a", @prompt.do_cycle("a.to_s(false,false)")
	end
	
	def test_6
		prep
		assert_equal "(b + c)", @prompt.do_cycle("a")
	end

	def test_7
		prep
		assert_equal "(b + c)", @prompt.do_cycle("a.u")
	end


	def test_function
		
		@prompt = Prompt.new(Yaclic::Kernel.new)

		@prompt.do_cycle("a << e+f")
		@prompt.do_cycle("f << g*h")

		
		result = (-10..10).map{|key| "#{key}".rjust(10) + " | ".blue + (key.to_f+1).to_s.green.bold }.join "\n"
		assert_equal result, @prompt.do_cycle("a[g,-10..10]")

	end

	def test_history
		
		@prompt = Prompt.new(Yaclic::Kernel.new)

		his = ["e<<a+b","x+yz","history"]

		@prompt.do_cycle his[0]
		@prompt.do_cycle his[1]

		assert_equal his.inspect, @prompt.do_cycle(his[2])

	end

	def test_implicite_multiplication
		@prompt = Prompt.new(Yaclic::Kernel.new)

		assert_equal "(4 * a)", @prompt.do_cycle("4a")
	end

	def test_implicite_multiplication_2
		@prompt = Prompt.new(Yaclic::Kernel.new)

		assert_equal "(b / (7 * c))", @prompt.do_cycle("b/7c")
	end

	def test_implicite_multiplication_3
		@prompt = Prompt.new(Yaclic::Kernel.new)

		assert_equal "(a * (b * c))", @prompt.do_cycle("a b c")
	end

	def test_implicite_multiplication_4
		@prompt = Prompt.new(Yaclic::Kernel.new)

		assert_equal "((a + b) * c)", @prompt.do_cycle("(a+b)c")
	end

	def test_word
		@prompt = Prompt.new(Yaclic::Kernel.new)

		assert_equal "((a * b) * c)", @prompt.do_cycle("abc")
	end

	def test_word_2
		@prompt = Prompt.new(Yaclic::Kernel.new)

		assert_equal "_abc", @prompt.do_cycle("_abc")
	end

	def test_rational_output
		@prompt = Prompt.new(Yaclic::Kernel.new)

		assert_equal "10x-5", @prompt.do_cycle("1/100000")
	end

	def test_rational_output_2
		@prompt = Prompt.new(Yaclic::Kernel.new)

		assert_equal "3 10x8", @prompt.do_cycle("30*10**7")
	end

end
