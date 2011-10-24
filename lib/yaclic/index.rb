module Yaclic
class Index < Hash

	def to_s
		self.keys.map{|sym| "#{sym}".rjust(10).bold.cyan + " | ".blue + "#{@set[key].operation}" }.join "\n"
	end

end
end
