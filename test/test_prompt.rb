require 'test/unit'
require 'yac'

class PromptTest < Test::Unit::TestCase

	def setup
		$stdout = File.new("/dev/null","w")
		@prompt = Prompt.new
	end

	def test_simple_calc

		@prompt.do_cycle("d << a + b")
		@prompt.do_cycle("a << 3")
		@prompt.do_cycle("b << 4")

		assert @prompt.do_cycle("d.c").to_i,7
	end

	def teardown
		$stdout = STDOUT
	end
end
