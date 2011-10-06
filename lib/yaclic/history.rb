class History

	def initialize
		@ar = []
		@pointer = -1
	end

	def push!(str)

		silent_push!(str)
		@pointer = @ar.size
	end

	def silent_push!(str)

		# cleanup each push
		@ar.delete("")

		if @ar.last != str
			@ar.push(str)
		end

	end

	def up!(n=1)
		n.times { @pointer -= 1 if @pointer > 0 }
		@ar[@pointer].nil? ? "" : @ar[@pointer].clone
	end

	def down!(n=1)
		n.times { @pointer += 1 if @pointer < @ar.size-1 && !@ar.nil? }
		@ar[@pointer].nil? ? (@ar[@pointer-1].nil? ? "" : @ar[@pointer-1].clone) : @ar[@pointer].clone
	end

	def down?
		(@pointer >= @ar.size-1)
	end

	def to_s
		@ar.inspect.cyan
	end

	def to_a
		@ar.clone
	end

end
