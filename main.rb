#!/usr/bin/ruby

require 'environment'
require 'colored'


bind = Environment.new.env

loop do
	#TODO recognize keystrokes like up,down (to make history etc)
	#	error handling
	
	puts
	print " >> ".bold.green + "|  ".blue

	input = gets

	begin
		output = "#{eval(input,bind)}"
	rescue SyntaxError, NoMethodError => error
		debug error.to_s
		output = "error, statement ignored".red
	rescue CannotCalculateException
		output = "cannot be calculated".red
	end

	puts (" << ".yellow.bold + "|  ".blue + output)
end
