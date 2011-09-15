#!/usr/bin/ruby

require 'environment'


bind = Environment.new.env

loop do
	#TODO recognize keystrokes like up,down (to make history etc)
	#	error handling
	
	print "-> "
	str = gets

	puts ("<- #{eval(str,bind)}")
end
