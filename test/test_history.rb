require 'test/unit'
require 'yaclic'

class HistoryTest < Test::Unit::TestCase

	def setup
		@ar = ["1234","789","foo bar #### and all"]
	end

	def test_push

		his = History.new
		@ar.each {|e| his.push! e}

		assert_equal @ar.inspect, "#{his}"

	end

	def test_push_2

		his = History.new
		his.push! ""
		@ar.each {|e| his.push! e}
		his.push! ""

		assert_equal @ar.inspect, "#{his}"
	end

	def test_up
	
		his = History.new
		@ar.each {|e| his.push! e}

		assert_equal @ar[2], his.up!

	end


	def test_down

		his = History.new
		@ar.each {|e| his.push! e}

		his.up!
		his.up!
		his.up!
		his.up!

		assert_equal @ar[1], his.down!
	
	end

	# last down should give ""
	def test_down_2

		his = History.new
		@ar.each {|e| his.push! e}

		his.up!
		his.down!

		assert_equal "", his.down!

	end

end
