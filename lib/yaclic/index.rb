module Yaclic
class Index < Hash

	def self.[](sym)
		super
	end

	def to_s
		keys.map{|sym| "#{sym}".rjust(10).bold.cyan + " | ".blue + "#{self.[](sym).operation}" }.join "\n"
	end

end
end
