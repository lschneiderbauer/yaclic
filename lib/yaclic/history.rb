class History

	def initialize
		@ar = []
		@pointer = 0
	end

	def push!(str)
		@ar.push(str) if str != ""	
		@pointer += 1
	end

	def up!
		@pointer -= 1 if @pointer > 0
		@ar[@pointer].clone
	end

	def down!
		@pointer += 1 if @pointer < @ar.size && !@ar.nil?
		@ar[@pointer].nil? ? "" : @ar[@pointer].clone
	end

	def to_s(current=false)	
		unless current
			@ar.inspect.cyan
		else
			@ar[@pointer]
		end
	end

end
