# define this class in ruby 1.8 (since it is used in 1.9 for domain errors)
class Math::DomainError < Exception; end if RUBY_VERSION < "1.9"

class Prompt

	def initialize
		@env = Environment.new
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

		begin
			output = "#{@env.evaluate(input)}"

		rescue SyntaxError, NoMethodError => error
			debug "#{error.class} | #{error}"
			output = "Error, statement ignored".red
		rescue CannotCalculateError
			output = "Cannot be calculated atm".red
		rescue ArgumentError => error
			debug error.to_s	
			output = "Wrong number of arguments".red
		rescue NameError => error
			debug error.to_s
			output = "Use lower case letters as symbols".red
		rescue ZeroDivisionError
			output = "Cannot divide by 0".red
		rescue Errno::EDOM, Math::DomainError
			output = "Numerical argument is out of domain".red
		rescue SystemStackError
			output = "You seem to have a loop somewhere. Fix that!".red
		end

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
		ignore_next = false

		until (ch = get_char).chr == "\r" do 
			debug ch
	
			unless ignore_next # to prevent umlauts from messing up the string
			case ch
				when 3 then # strg + c (simulate quit)
					print "quit"
					str << "quit"
					ch.chr = "\r"

				when 195 then ignore_next = true # umlaut comes
				when 27 then ignore_next = true # arrow comes
				#when 91 then #arrow
				when 65 then #up
					debug "arrow up"

					# add the current string if needed
					if @env.history.down?
						debug "down"
						@env.history.silent_push!(str) 
					end

					reset_text(str)
					str = @env.history.up!
					str = "(" + str + ")" unless (str.empty? || (str[0,1] == "(" && str[-1,1] == ")"))
					print get_in_prompt + str


				when 66 then #down
					debug "arrow down"
					
					reset_text(str)
					str = @env.history.down!
					str = "(" + str + ")" unless (str.empty? || (str[0,1] == "(" && str[-1,1] == ")"))
					print get_in_prompt + str


				when 67 then #right - ignore
				when 68 then #left - ignore
				when 127 then print "\b \b" if str != ""; str.chop!
				else print ch.chr; str << ch.chr; debug "#{ch} added to str"
			end
			else
				ignore_next = false
			end

		end
		print "\n"

		return str
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
