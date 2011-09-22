class Prompt

	def initialize
		@bind = Environment.new(self).env
		@history = []
		@pointer = 0
	end

	def history
		@history.clone
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
			@history.push(input)
			puts input
		end

		begin
			output = "#{eval(input,@bind)}"
		rescue SyntaxError, NoMethodError => error
			debug error.to_s
			output = "error, statement ignored".red
		rescue CannotCalculateException
			output = "cannot be calculated atm".red
		end

		# for safety reasons, print a warning if using the '=' character
		if input.include? "=" then
			output = "warning:".red.underline +
				"\tunless you know, what you do, use '<<' instead of '=' as access operator!\n".red +
				"\t\t'=' does most likely NOT behave as you expect it to do.\n".red + output; end

		last_line = ""
		output.each_line do |line|
			puts get_out_prompt + line	
			last_line = line
		end

		return last_line

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
				when 195 then ignore_next = true # umlaut kommt
				when 27 then #arrow
				when 91 then #arrow
				when 65 then #up
					debug "arrow up"
					if !@history.nil? && @pointer > 0	

						if @pointer == @history.size && str != ""  # the last saving
							@history.push(str)
						end

						@pointer -= 1

						reset_text(str)
						str = @history[@pointer].clone
						print get_in_prompt + str
					end

				when 66 then #down
					debug "arrow down"
					if !@history.nil? && @pointer <= @history.size-1
						@pointer += 1

						reset_text(str)
						str = (@pointer != @history.size ? @history[@pointer].clone : "")
						print get_in_prompt + str
					end

				when 67 then #left - ignore
				when 68 then #right - ignore
				when 127 then print "\b \b" if str != ""; str.chop!
				else print ch.chr; str << ch.chr; debug "#{ch} added to str"
			end
			else
				ignore_next = false
			end

		end
		print "\n"

		@history.push(str.strip) if str.strip != "" # history
		debug "new history: #{@history.inspect}"
		@pointer = @history.size
		return str
	end

	def get_char
		system "stty raw -echo"
		ch = STDIN.getc
	ensure
		system "stty -raw echo"
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
