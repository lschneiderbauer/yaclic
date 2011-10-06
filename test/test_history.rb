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

		assert_equal @ar.push("").inspect, "#{his}"
	end

	def test_push_3

		his = History.new
		@ar.each {|e| his.push! e}

		his.up!
		his.up!
		his.push! "blubb"

		assert_equal "blubb", his.up!
	end

	def test_push_4

		his = History.new
		@ar.each {|e| his.push! e}

		his.push! @ar.last

		assert_equal @ar.inspect, "#{his}"

	end

	def test_up
	
		his = History.new
		@ar.each {|e| his.push! e}

		assert_equal @ar[2], his.up!

	end

	def test_up_2
		
		his = History.new
		@ar.each {|e| his.push! e}

		assert_equal @ar[1], his.up!(2)

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

	def test_down_2

		his = History.new
		@ar.each {|e| his.push! e}

		his.up!
		his.down!

		assert_equal @ar.last, his.down!

	end

	def test_down_3

		his = History.new
		@ar.each {|e| his.push! e}

		his.up!
		his.up!
		
		assert_equal @ar.last, his.down!(2)

	end

	def test_to_a

		his = History.new
		@ar.each {|e| his.push! e}

		assert_equal @ar, his.to_a

	end

end
