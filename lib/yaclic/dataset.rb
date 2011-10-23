module Yaclic
class Dataset

	def initialize(f, var, range, step=1)

		# set up new environment
		# TOOD: reserve keywords with ___
		# TODO: throw errors on weird wrong parameters
		old_colored = $colored	
		$colored = false
		env = Environment.new
		env.evaluate "__function << #{f.u}"
		debug f.u

		# set all unset variables to 1
		env.evaluate "#{var.to_s(false,false)} << 1"

		go = false
		until go do
			begin
				env.evaluate "__function.c"
				go = true
			rescue CannotCalculateError => error
				env.evaluate "#{error.expr_p.to_s(false,false)} << 1"
			end
		end
	
		@set = {}
		range.step(step) do |num|
			env.evaluate "#{var.to_s(false,false)} << #{num}"
			@set[num] = env.evaluate("__function.cf").to_f
		end
		$colored = old_colored
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
			"gnuplot support not available".red
		end

	end


	def to_s
		@set.keys.sort.map{|key| @set[key].to_s.green.bold }.join "\n"
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
