#!/usr/bin/ruby

require 'environment'
require 'prompt'
require 'colored'

#bind = Environment.new.env
prompt = Prompt.new

prompt.start_loop

#loop do
#	puts
#	print " >> ".bold.green + "|  ".blue
#
#	input = reader.reads
#
#	begin
#		output = "#{eval(input,bind)}"
#	rescue SyntaxError, NoMethodError => error
#		debug error.to_s
#		output = "error, statement ignored".red
#	rescue CannotCalculateException
#		output = "cannot be calculated".red
#	end
#
#	puts (" << ".yellow.bold + "|  ".blue + output)
#end
