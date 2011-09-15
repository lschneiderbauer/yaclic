#!/usr/bin/ruby

require './debug.rb'
require 'operator'
require 'expression'
require 'expression_pointer'


class Environment

	def env
		return binding
	end

	def method_missing(sym, *args)

		debug "method_missing for #{sym}"
		if sym.to_s =~ /^.*/	# if method-name is ascii ..
			if eval("@#{sym}.nil?",self.env)

				# make new variable with ExpressionPointer

				debug("@#{sym} = ExpressionPointer.new(nil,:#{sym})")
				eval("@#{sym} = ExpressionPointer.new(nil,:#{sym})",self.env)

				debug("new expression pointer initialized: #{eval("@#{sym}")}",1)	
			else
				debug("expression pointer in use",1)
			end
			return eval("@#{sym}",self.env)
		end

	end

	def expression_pointers
		@expression_pointers ||= []
	end
	
	# define calculator commands
	# ====================================
	def quit
		exit
	end

end

bind = Environment.new.env

loop do
	#TODO recognize keystrokes like up,down (to make history etc)

	print "-> "
	str = gets

	puts ("<- #{eval(str,bind)}")
end
