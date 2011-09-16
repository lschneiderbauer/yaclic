require 'colored'
require 'environment'

class Prompt

	def initialize
		@bind = Environment.new.env
		@history = []
		@pointer = 0
	end


	def start_loop
		
		loop do

			puts 
			print get_in_prompt

			input = reads

			begin
				output = "#{eval(input,@bind)}"
			rescue SyntaxError, NoMethodError => error
				debug error.to_s
				output = "error, statement ignored".red
			rescue CannotCalculateException
				output = "cannot be calculated atm".red
			end

			puts get_out_prompt + output
		end

	end

	private

	def reads
		str = ""	
		ch = 0
		until ch.chr == "\r" do 
			ch = get_char
		
			case ch
				when 27 then #arrow
				when 91 then #arrow
				when 65 then #up
					debug "arrow up"
					if !@history.nil? && @pointer > 0	

						if @pointer == @history.size && str != ""  # the last saving
							@history.push(str)
							#@pointer+=1
						end

						@pointer -= 1

						reset_text(str)

						str = @history[@pointer].clone

						print get_in_prompt + str
					end

				when 66 then #down
					debug "arrow down"
					if !@history.nil? && @pointer < @history.size-1
						@pointer += 1

						reset_text(str)

						str = @history[@pointer].clone

						print get_in_prompt + str
					end

				when 67 then #left - ignore
				when 68 then #right - ignore
				when 127 then print "\b \b" if str != ""; str.chop!
				else print ch.chr; str << ch.chr; debug "#{ch} added to str"
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
	end

end
