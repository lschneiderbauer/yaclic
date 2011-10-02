class Dataset

	def initialize(f, var, range, step=1)

		# set up new environment
		# TOOD: reserve keywords with ___
		old_colored = $colored	
		$colored = false
		bind = Environment.new(nil).env
		eval("___function << #{f.u}",bind)

		# set all unset variables to 1
		eval("#{var.to_s(false,false)} << 1",bind)

		go = false
		until go do
			begin
				eval("___function.c",bind)
				go = true
			rescue CannotCalculateError => error
				eval("#{error.expr_p.to_s(false,false)} << 1",bind)
			end
		end
	
		@set = {}
		range.step(step) do |num|
			eval("#{var.to_s(false,false)} << #{num}",bind)
			@set[num] = eval("___function.c",bind).to_f
		end
		$colored = old_colored
	end


	def plot

		unless $hasnot_gnuplot

			# plot some stuff
			Gnuplot.open do |gp|
				Gnuplot::Plot.new gp do |plot|
					#plot.title "blah"
					#plot.ylabel "y"
					#plot.xlabel "x"

					x = []
					y = []
					@set.each do |key,value|

					end

					plot.data << Gnuplot::DataSet.new(@set) do |ds|
						ds.with = "linespoints"
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
