# define this class in ruby 1.8 (since it is used in 1.9 for domain errors)
class Math::DomainError < Exception; end if RUBY_VERSION < "1.9"

class Prompt

	def initialize(kernel)
		@kernel = kernel
	end


	def start_loop

		loop do
			do_cycle
		end

	end


	def do_cycle(arg=nil)

		print get_in_prompt

		if arg.nil?		# is input already there?
			input = reads
		else
			input = arg
			puts input
		end

		error = nil
		output =
		begin
			"#{@kernel.evaluate(input)}"
		rescue SyntaxError, NoMethodError => error
			"Error, statement ignored".red
		rescue Yaclic::CannotCalculateError => error
			"Cannot be calculated atm".red
		rescue Yaclic::SymbolPreservedError => error
			"Symbol preserved.".red
		rescue ArgumentError => error
			"Wrong number of arguments".red
		rescue NameError => error
			"Use lower case letters as symbols".red
		rescue ZeroDivisionError => error
			"Cannot divide by 0".red
		rescue Errno::EDOM, Math::DomainError => error
			"Numerical argument is out of domain".red
		rescue SystemStackError => error
			"You seem to have a loop somewhere. Fix that!".red
		end

		# raise error if on debug mode
		raise error if !error.nil? && @kernel.debug

		# for safety reasons, print a warning if using the '=' character
		if input.include? "=" then
			output = "warning:".red.underline +
				"\tunless you know, what you do, use '<<' instead of '=' as assignment operator!\n".red +
				"\t\t'=' does most likely NOT behave as you expect it to do.\n".red + output; end

		output.each_line do |line|
			puts get_out_prompt + line	
		end

		return output

	end


	private

	def reads
		str = ""
		ch = 0
		ignore_next = false

		until ch.chr == "\r" do 
			ch = get_char
	
			unless ignore_next # to prevent umlauts from messing up the string
			case ch
				when 3 then # strg + c (simulate quit)
					print "quit"
					str << "quit"
					ch = 13		# = "\r"

				when 195 then ignore_next = true # umlaut comes
				when 27 then ignore_next = true # arrow comes
				#when 91 then #arrow
				when 65 then #up

					# add the current string if needed
					if @kernel.history.down?
						@kernel.history.silent_push!(str) 
					end

					reset_text(str)
					str = @kernel.history.up!
					print get_in_prompt + str


				when 66 then #down
					
					reset_text(str)
					str = @kernel.history.down!
					print get_in_prompt + str


				when 67 then #right - ignore
				when 68 then #left - ignore
				when 127 then print "\b \b" if str != ""; str.chop!
				else
					print ch.chr
					str << ch.chr
			end
			else
				ignore_next = false
			end

		end
		print "\n"

		return str.chomp
	end

	def get_char
		old_state = `stty -g`
		system "stty raw -echo"

		ch = (RUBY_VERSION < "1.9" ? STDIN.getc : STDIN.getbyte)
	ensure
		system "stty #{old_state}"
		return ch
	end

	def get_in_prompt
		" >> ".bold.green + "|  ".blue
	end

	def get_out_prompt
		" << ".bold.yellow + "|  ".blue
	end

	def reset_text(str)
		(get_in_prompt.length + str.length).times { print "\b \b" }
		# (get_in and get_out_prompt 's length are equal)
	end

end
