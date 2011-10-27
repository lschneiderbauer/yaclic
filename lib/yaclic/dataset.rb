module Yaclic
class Dataset

	def initialize(kernel, sym_f, sym_var, range, step)

		# clone the whole environment
		#
		new_kernel = kernel.clone

		# default unset variables to 1
		#
		new_kernel.index[sym_var] << range.begin

		go = false
		(begin
			new_kernel.index[sym_f].to_float
			go = true

		rescue CannotCalculateError => error
			error.expr_p << 1

		end) until go


		# create the dataset
		#
		@set = {}
		range.step(step) do |num|
			new_kernel.index[sym_var] << num
			@set[num] = new_kernel.index[sym_f].to_float
		end

	end

	def set
		@set
	end

	def plot

		unless $hasnot_gnuplot

			# plot some stuff
			Gnuplot.open do |gp|
				Gnuplot::Plot.new gp do |plot|
					plot.grid

					plot.data << Gnuplot::DataSet.new(@set) do |ds|
						ds.with = "linespoints"
						ds.linewidth = 2
						ds.notitle
					end 
				end
			end

			"Here you are.".cyan

		else
			"Gnuplot support is not available.".red
		end

	end


	def to_s
		@set.keys.sort.map{|key| "#{key}".rjust(10).cyan + " | ".blue + @set[key].to_s.green.bold }.join "\n"
	end
end
end

class Hash
	
	def to_gplot
		x = []
		y = []
		
		self.each_key.sort.each do |key|
			x << key
			y << self[key]
		end

		[x,y].to_gplot
	end

end
